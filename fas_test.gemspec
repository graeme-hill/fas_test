spec = Gem::Specification.new do |s|
  s.name = "fas_test"
  s.version = "0.0.7"
  s.authors = ["Graeme Hill"]
  s.email = "graemekh@gmail.com"
  s.homepage = "https://github.com/graeme-hill/fas_test"
  s.platform = Gem::Platform::RUBY
  s.description = File.open("README").read.gsub("\n","<br/><br/>")
  s.summary = "A simple automated testing framework designed to be fast and easy to use."
  s.files = ["README", "bin/fastest", "lib/fas_test.rb", "test/fas_test_tests.rb", "fas_test.gemspec"]
  s.require_path = "lib"
  s.bindir = "bin"
  s.executables = ["fastest"]
  s.test_files = ["test/fas_test_tests.rb"]
  s.extra_rdoc_files = ["README"]
  s.has_rdoc = true
end