require 'stringio'
require 'lib/fas_test'

class FasTestTests < FasTest::TestClass
    
  def setup
    $stdout = StringIO.new
  end
  
  def teardown
    $stdout = STDOUT
  end
  
  def test__redirect_io
    $stdout = StringIO.new
    puts 'hello?'
    assert_equal "hello?\n", $stdout.string
  end
  
  def test__run_tests_in_class__results_are_valid
    runner = FasTest::TestRunner.new
    runner.run_tests_in_class(FasTestTestClassTests)
    
    assert_equal(5, runner.test_results.length, "wrong number of tests")
    
    assert_equal(
      FasTest::TestStatuses::PASS,
      runner.test_results['FasTestTests::FasTestTestClassTests::test__pass1'].status)
      
    assert_equal(
      FasTest::TestStatuses::FAIL,
      runner.test_results['FasTestTests::FasTestTestClassTests::test__fail1'].status)
        
    assert_equal(
        FasTest::TestStatuses::CRASH,
        runner.test_results['FasTestTests::FasTestTestClassTests::test__crash1'].status)
    
    assert_equal(
      FasTest::TestStatuses::FAIL,
      runner.test_results['FasTestTests::FasTestTestClassTests::test__assert_true_with_false'].status)
          
    assert_equal(
      FasTest::TestStatuses::PASS,
      runner.test_results['FasTestTests::FasTestTestClassTests::test__asert_true_with_true'].status)
  end

  class FasTestTestClassTests < FasTest::TestClass

    def test__pass1
    end
    
    def test__fail1
      fail("this is an expected fail")
    end
    
    def test__crash1
      i.am.calling.come.methods.that.dont.exist.so.it.should.crash
    end
    
    def test__assert_true_with_false
      assert_true(false)
    end
    
    def test__asert_true_with_true
      assert_true(true)
    end
    
  end
  
end

