require 'lib/fas_test'

test_runner = FasTest::TestRunner.new
test_runner.run_tests_in_folder(".")
test_runner.print_summary