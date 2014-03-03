Gem::Specification.new do |s|
  s.name         = 'unicode_alphanumeric'
  s.version      = '0.0.0'
  s.date         = '2014-03-03'
  s.summary      = 'Filters non-alphanumeric Unicode characters'
  s.description  = 'Removes, replaces, transforms, or detects non-alphanumeric Unicode characters in a string'
  s.authors      = ['Jarrett Colby']
  s.email        = 'jarrett@madebyhq.com'
  s.files        = Dir.glob('lib/**/*')
  s.homepage     = 'http://madebyhq.com/'
  
  s.add_runtime_dependency 'unicode', '>= 0.4.4'
  
  s.add_development_dependency 'minitest'
  s.add_development_dependency 'turn'
end