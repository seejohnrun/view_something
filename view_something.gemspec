require File.dirname(__FILE__) + '/lib/view_something/version'

spec = Gem::Specification.new do |s|
  
  s.name = 'view_something'
  s.author = 'John Crepezzi'
  s.add_development_dependency('rspec')
  s.description = 'Easily use SQL views with ActiveRecord'
  s.email = 'john.crepezzi@gmail.com'
  s.files = Dir['lib/**/*.rb']
  s.has_rdoc = true
  s.homepage = 'http://seejohnrun.github.com/view_something/'
  s.platform = Gem::Platform::RUBY
  s.require_paths = ['lib']
  s.summary = 'Use SQL views seamlessly with ActiveRecord'
  s.test_files = Dir.glob('spec/*.rb')
  s.version = ViewSomething::VERSION
  s.rubyforge_project = 'ViewSomething'

end
