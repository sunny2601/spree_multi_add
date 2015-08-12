# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_multi_add'
  s.version     = '2.1.4'
  s.summary     = 'Extension that adds a multi-add feature to the product page'
  s.description = 'Extension that adds a multi-add feature to the product page'
  s.required_ruby_version = '>= 1.9.3'

  s.author    = 'Patrik Johansson'
  s.email     = 'patrik.johansson@kentor.se'

  s.files       = `git ls-files`.split("\n")
  #s.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '= 2.4.10.beta'

  s.add_development_dependency 'capybara', '~> 2.1'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'factory_girl', '~> 4.2'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.13'
  s.add_development_dependency 'sass-rails', '~> 4.0.1'
  s.add_development_dependency 'capybara-webkit'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'pry'
end
