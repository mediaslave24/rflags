Gem::Specification.new do |s|
  s.name = 'rflags'
  s.version = '0.0.2'
  s.summary = 'Boolean flags with different backends'
  s.description = 'Stores boolean flags in file, redis or memory'
  s.author = ['Michael Lutsiuk']
  s.email = 'mmaccoffe@gmail.com'
  s.license = 'MIT'
  s.homepage = 'https://github.com/mediaslave24/rflags'
  s.files = Dir['Rakefile', 'Gemfile', 'LICENSE', 'test/**/*.rb', 'lib/**/*.rb']

  s.add_development_dependency 'rake', '~> 10.2'
  s.add_development_dependency 'minitest', '~> 5.5'
end
