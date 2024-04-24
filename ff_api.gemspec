Gem::Specification.new do |s|
  s.name        = "ff_api"
  s.version     = "0.2.1"
  s.summary     = "Finalforms API Helper"
  s.description = "An easy to use ruby gem to fetch data from the finalforms database"
  s.authors     = ["Austin Cotant", "Skyler Cummins"]
  s.email       = "austin@finalforms.com"
  s.files       = [
    "lib/ff_api.rb",
    "lib/ff_api/school.rb",
    "lib/ff_api/district.rb",
  ]
  s.homepage    =
    "https://rubygems.org/gems/ff_api"
  s.license       = "MIT"
  s.required_ruby_version = ">= 3.0"
end
