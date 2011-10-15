module FasTest

  # Used to discover tests and actually run them.  Normally this class will be
  # used by the command line client.
  class TestRunner

    attr_reader :test_results

    def initialize(verbose = false)
      @verbose = verbose
      @assertion_count = 0
      @test_results = {}
    end

    def run_tests_in_class(test_class)
      test_instance = init_test_instance(test_class)
      begin
        setup_failed = false
        begin
          test_instance.class_setup
        rescue Object => ex
          puts "Superfail: Crashed when running #{test_class.name}::class_setup"
          puts "  -> #{ex.class.name}: #{ex.message}"
          pretty_print_stack_trace(ex)
          setup_failed = true
        end
        unless setup_failed
          get_all_test_method_names(test_class).each do |test_method_name|
            run_test(test_instance, test_method_name)
          end
        end
      ensure
        test_instance.class_teardown
      end
    end

    def init_test_instance(test_class)
      test_instance = test_class.new
      test_instance.runner = self
      return test_instance
    end

    def increment_assert_count
      @assertion_count += 1
    end

    def run_test(test_instance, test_method_name)
      begin
        status = TestStatuses::PASS
        setup_succeeded = try_test_setup(test_instance)
        test_instance.needs_teardown = true
        if setup_succeeded
          test_instance.send(test_method_name)
          if @verbose
            puts "Pass: #{test_instance.class.name}::#{test_method_name}"
          end
        end
      rescue AssertionException => ex
        status = TestStatuses::FAIL
        try_test_teardown(test_instance)
        puts "Fail: #{test_instance.class.name}::#{test_method_name}"
        puts "  -> #{ex.message}"
      rescue Exception => ex
        status = TestStatuses::CRASH
        try_test_teardown(test_instance)
        puts "Crash: #{test_instance.class.name}::#{test_method_name}"
        puts "  -> #{ex.class.name}: #{ex.message}"
        pretty_print_stack_trace(ex)
      rescue Object => obj
        status = TestStatuses::CRASH
        try_test_teardown(test_instance)
        puts "Crash: #{test_instance.class.name}::#{test_method_name}"
        puts "  -> Raised non-exception: #{obj.to_s}"
      ensure
        try_test_teardown(test_instance)
        record_test_result(test_instance, test_method_name, status)
      end
    end

    def record_test_result(test_instance, test_method_name, status)
      test_class = test_instance.class
      key = "#{test_class.name}::#{test_method_name}"
      @test_results[key] = TestResult.new(test_class, test_method_name, status)
    end

    def try_test_setup(test_instance)
      setup_succeeded = true
      begin
        test_instance.test_setup
      rescue Exception => ex
        setup_succeeded = false
        puts "Superfail: #{test_instance.class.name}::test_setup"
        puts "  -> #{ex.class.name}: #{ex.message}"
        pretty_print_stack_trace(ex)
      end
      return setup_succeeded
    end

    def try_test_teardown(test_instance)
      if test_instance.needs_teardown
        begin
          test_instance.test_teardown
        ensure
          test_instance.needs_teardown = false
        end
      end
    end

    def pretty_print_stack_trace(exception)
      if @verbose
        exception.backtrace.each { |trace| puts "    #{trace}"}
      end
    end

    def run_tests_in_folder(path)
      load_test_files(path)
      find_test_classes.each do |test_class|
        run_tests_in_class(test_class)
      end
    end

    def load_test_files(path)
      Dir[File.join(path, '/**/*_tests.rb')].each { |file_name| load file_name }
    end

    def get_all_test_method_names(test_class)
      test_class.instance_methods.find_all { |m| m.to_s.start_with?('test__') }
    end

    def find_test_classes
      classes = []
      Module.constants.each do |constant|
        constant_str = constant.to_s
        if constant_str.end_with? "Tests"
          classes << eval(constant_str)
        end
      end
      return classes
    end

    def get_constant_type(construct)
      construct_class = construct.class
      if construct_class == Class
        return ConstantTypes::CLASS
      elsif construct_class == Module
        return ConstantTypes::MODULE
      else
        return ConstantTypes::OTHER
      end
    end

    def class_inherits_parent?(child_class, parent_class)
      child_class.ancestors.any? { |ancestor| ancestor == parent_class }
    end

    def print_summary
      pass_count = @test_results.values.find_all { |r| r.status == TestStatuses::PASS }.length
      fail_count = @test_results.length - pass_count
      puts "#{pass_count} passed; #{fail_count} failed; #{@assertion_count} assertions"
    end

  end

  # Base class for all test suites
  class TestClass

    attr_writer :runner
    attr_accessor :needs_teardown

    # This is called once before any of the tests in the class are run
    def class_setup
    end

    # This is called once after ALL the tests in the class are done
    def class_teardown
    end

    # This is called before EACH test
    def test_setup
    end

    # This is called after EACH test
    def test_teardown
    end

    def assert_true(expression, msg = "<no msg given>")
      @runner.increment_assert_count
      if expression != true
        raise AssertionException, "#{msg} | expected true but got #{expression.to_s}"
      end
    end

    def assert_equal(a, b, msg = "<no msg given>")
      @runner.increment_assert_count
      if a != b
        raise AssertionException, "#{msg} | expected '#{a}' but got '#{b}'"
      end
    end

    def fail(msg)
      raise AssertionException, msg
    end

  end

  # Exception thrown when an assertion in a test fails
  class AssertionException < Exception
  end

  # Represents the state of a finished test
  class TestResult

    attr_reader :test_class
    attr_reader :method_name
    attr_reader :status

    def initialize(test_class, method_name, status)
      @test_class = test_class
      @method_name = method_name
      @status = status
    end

  end

  # ENUM - Types that a ruby constant can refer to
  class ConstantTypes
    CLASS = 1
    MODULE = 2
    OTHER = 4
  end

  # ENUM - Test result states
  class TestStatuses
    PASS = 1
    FAIL = 2
    CRASH = 4
  end

end

