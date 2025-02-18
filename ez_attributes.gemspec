# frozen_string_literal: true

require_relative "lib/ez_attributes"

Gem::Specification.new do |spec|
  spec.name = "ez_attributes"
  spec.version = EzAttributes::VERSION
  spec.authors = ["Matheus Richard"]
  spec.email = ["matheusrichardt@gmail.com"]

  spec.summary = "Easily define initializers with keyword args."
  spec.description = "Easily define initializers with keyword args. It supports required and optional args."
  spec.homepage = "https://github.com/MatheusRich/ez_attributes.git"
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/MatheusRich/ez_attributes/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
