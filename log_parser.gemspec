# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name    = "log_parser"
  s.version = "0.0.1"
  s.authors = "Jędrzej Bryll"
  s.email   = "jedrzej.bryll@gmail.com"
  s.summary = "Simple log parser"

  s.files         = Dir["bin/*"] + Dir["lib/**/*.rb"] + Dir["spec/**/*"]
  s.test_files    = Dir["spec/**/*"]
  s.executables   = ["log_parser"]
  s.require_paths = ["lib"]

  s.add_runtime_dependency "thor", "~> 1.0", ">= 1.0.0"
end
