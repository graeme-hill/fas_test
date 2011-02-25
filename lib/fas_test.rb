module FasTest
  
  class TestRunner
    
    def initialize(verbose = false)
      @assertion_count = 0
      @success_count = 0
      @fail_count = 0
      @verbose = verbose
    end
    
    def run_tests_in_class(test_class)
      test_instance = init_test_instance(test_class)
      get_all_test_method_names(test_class).each do |test_method_name|
        run_test(test_instance, test_method_name)
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
        test_instance.setup
        test_instance.send(test_method_name)
        if @verbose
          puts "Pass: #{test_instance.class.name}::#{test_method_name}"
        end
        @success_count += 1
      rescue AssertionException => ex
        @fail_count += 1
        puts "Fail: #{test_instance.class.name}::#{test_method_name}"
        puts "  -> #{ex.message}"
      rescue Exception => ex
        @fail_count += 1
        puts "Crash: #{test_instance.class.name}::#{test_method_name}"
        puts "  -> #{ex.class.name}: #{ex.message}"
        pretty_print_stack_trace(ex)
      rescue Object => obj
        @fail_count += 1
        puts "Crash: #{test_instance.class.name}::#{test_method_name}"
        puts "  -> Raised non-exception: #{obj.to_s}"
      ensure
        test_instance.teardown
      end
    end
    
    def pretty_print_stack_trace(exception)
      exception.backtrace.each { |trace| puts "    #{trace}"}
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
      test_class.instance_methods.find_all { |m| m.start_with?('test__') }
    end
    
    def find_test_classes
      classes = []
      Module.constants.each do |constant|
        if constant.end_with? "Tests"
          classes << eval(constant)
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
      puts "#{@success_count} passed; #{@fail_count} failed; #{@assertion_count} assertions"
    end

  end
  
  class ConstantTypes
    CLASS = 1
    MODULE = 2
    OTHER = 3
  end
  
  class TestClass
    
    attr_writer :runner
    
    def setup
    end
    
    def teardown
    end
    
    def assert_true(expression)
      @runner.increment_assert_count
      if expression != true
        raise AssertionException, "expected true but got #{expression.to_s}"
      end
    end
    
    def assert_equal(a, b)
      @runner.increment_assert_count
      if a != b
        raise AssertionException, "expected #{a} but got #{b}"
      end
    end
    
  end
  
  class AssertionException < Exception
  end
  
end

