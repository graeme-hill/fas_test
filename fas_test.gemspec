spec = Gem::Specification.new do |s|
  s.name = "fas_test"
  s.version = "0.0.2"
  s.authors = ["Graeme Hill"]
  s.email = "graemekh@gmail.com"
  s.homepage = "https://github.com/graeme-hill/fas_test"
  s.platform = Gem::Platform::RUBY
  s.description = File.open("README").read
  s.summary = "A simple automated testing framework designed to be fast and easy to use."
  s.files = ["README", "bin/fastest.rb", "lib/fas_test.rb", "test/fas_test_tests.rb"]
  s.require_path = "lib"
  s.test_files = ["test/fas_test_tests.rb"]
  s.extra_rdoc_files = ["README"]
  s.has_rdoc = true
end