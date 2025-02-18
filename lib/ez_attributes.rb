# frozen_string_literal: true

# Easily define initializers with keyword args.
# It supports required and optional args.
#
# @example
#   class User
#     extend EzAttributes
#
#     # Here name and age are required, and email has a default value, so it is optional.
#     attributes :name, :age, email: 'guest@user.com'
#   end
#
#   User.new(name: 'Matheus', age: 22)
#   => #<User:0x000055bac152f130 @name="Matheus", @age=22, @email="guest@user.com">
module EzAttributes
  # Gem version
  VERSION = "0.3.0"

  # Attributes that won't have a getter to prevent conflicts with default methods
  EXCEPTIONS = [:class].freeze

  def self.extended(other)
    other.extend configure
  end

  def self.configure(getters: true)
    mod = Module.new

    mod.module_eval do
      # Defines multiple keyword arguments for a class initializer
      define_method :attributes do |*args, **args_with_default|
        required_args = args.map { |name| "#{name}:" }
        optional_args = args_with_default.map { |name, _| "#{name}: __args_with_default[:#{name}]" }
        init_args = (required_args + optional_args).join(", ")

        define_method("__args_with_default", -> { Marshal.load(Marshal.dump(args_with_default)) })
        private :__args_with_default

        all_args = args + args_with_default.keys
        attr_reader(*(all_args - EXCEPTIONS)) if getters

        class_eval <<~RUBY, __FILE__, __LINE__ + 1
          def initialize(#{init_args})
            #{all_args.map { |name| "@#{name} = binding.local_variable_get(:#{name})" }.join("; ")}
          end
        RUBY
      end

      # Defines a single keyword argument for a class initializer
      alias_method :attribute, :attributes
    end

    mod
  end
end
