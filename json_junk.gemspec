Gem::Specification.new do |s|
	# Metadata
  s.name        = 'json_junk'
  s.version     = '0.1.0'
  s.date        = '2013-11-10'
  s.summary     = "Puts junk values in files containing JSON"
  s.description = "A simple interface to put junk values to your JSON files."
  s.authors     = ["Marko Hlebar"]
  s.email       = 'marko.hlebar@gmail.com'
  s.files       = 
  s.homepage    =
    'https://github.com/markohlebar/json-junk'
  s.license       = 'MIT'
  
  # Manifest
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  # Dependencies
  s.add_development_dependency "minitest"
end