Gem::Specification.new do |spec|
  spec.name                   = "sinatra-validations"
  spec.version                = "1.0.0"
  spec.date                   = "2016-05-18"
  spec.summary                = "Validation of params for Sinatra"
  spec.description            = "Validation of params for Sinatra"
  spec.authors                = ["Pedro Gimenez"]
  spec.email                  = ["me@pedro.bz"]
  spec.files                  = Dir["lib/*.rb", "lib/**/*.rb"]
  spec.homepage               = "http://github.com/pedrogimenez/sinatra-validations"
  spec.extra_rdoc_files       = ["README.md"]
  spec.required_ruby_version  = ">= 2.1.0"
  spec.licenses               = ["MIT"]

  spec.add_dependency "sinatra"

  spec.add_development_dependency "rspec"
end
