#!/usr/bin/ruby

require 'rubygems'

spec = eval File.open("fas_test.gemspec").read

system %Q{rm *.gem; echo "Y\n" | gem uninstall -a fas_test; gem build fas_test.gemspec; gem install fas_test-#{spec.version}.gem}