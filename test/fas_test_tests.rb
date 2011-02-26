require 'rubygems'
require 'sqlite3'
require 'stringio'
require 'lib/fas_test'

class FasTestTests < FasTest::TestClass
    
  def setup
    $stdout = StringIO.new
    @db = SQLite3::Database.new ":memory:"
    @db.execute("CREATE TABLE Foo (id int, foobar varchar(100));")
  end
  
  def teardown
    @db.execute("DELETE FROM Foo;")
    $stdout = STDOUT
  end

  def test__redirect_io
    $stdout = StringIO.new
    puts 'hello?'
    assert_equal "hello?\n", $stdout.string
  end
  
  def test__this_is_a_temp_test11
    @db.execute("INSERT INTO Foo VALUES (1, 'qwer')")
    @db.execute("INSERT INTO Foo VALUES (1, 'asdf')")
    @db.execute("INSERT INTO Foo VALUES (1, 'zxcv')")
    rows = @db.execute("SELECT foobar FROM Foo;")
    
    assert_equal(3, rows.length)
    assert_equal('qwer', rows[0][0])
    assert_equal('asdf', rows[1][0])
    assert_equal('zxcv', rows[2][0])
  end
  def test__this_is_a_temp_test10
    @db.execute("INSERT INTO Foo VALUES (1, 'qwer')")
    @db.execute("INSERT INTO Foo VALUES (1, 'asdf')")
    @db.execute("INSERT INTO Foo VALUES (1, 'zxcv')")
    rows = @db.execute("SELECT foobar FROM Foo;")
    
    assert_equal(3, rows.length)
    assert_equal('qwer', rows[0][0])
    assert_equal('asdf', rows[1][0])
    assert_equal('zxcv', rows[2][0])
  end
  def test__this_is_a_temp_test9
    @db.execute("INSERT INTO Foo VALUES (1, 'qwer')")
    @db.execute("INSERT INTO Foo VALUES (1, 'asdf')")
    @db.execute("INSERT INTO Foo VALUES (1, 'zxcv')")
    rows = @db.execute("SELECT foobar FROM Foo;")
    
    assert_equal(3, rows.length)
    assert_equal('qwer', rows[0][0])
    assert_equal('asdf', rows[1][0])
    assert_equal('zxcv', rows[2][0])
  end
  def test__this_is_a_temp_test8
    @db.execute("INSERT INTO Foo VALUES (1, 'qwer')")
    @db.execute("INSERT INTO Foo VALUES (1, 'asdf')")
    @db.execute("INSERT INTO Foo VALUES (1, 'zxcv')")
    rows = @db.execute("SELECT foobar FROM Foo;")
    
    assert_equal(3, rows.length)
    assert_equal('qwer', rows[0][0])
    assert_equal('asdf', rows[1][0])
    assert_equal('zxcv', rows[2][0])
  end
  def test__this_is_a_temp_test7
    @db.execute("INSERT INTO Foo VALUES (1, 'qwer')")
    @db.execute("INSERT INTO Foo VALUES (1, 'asdf')")
    @db.execute("INSERT INTO Foo VALUES (1, 'zxcv')")
    rows = @db.execute("SELECT foobar FROM Foo;")
    
    assert_equal(3, rows.length)
    assert_equal('qwer', rows[0][0])
    assert_equal('asdf', rows[1][0])
    assert_equal('zxcv', rows[2][0])
  end
  def test__this_is_a_temp_test6
    @db.execute("INSERT INTO Foo VALUES (1, 'qwer')")
    @db.execute("INSERT INTO Foo VALUES (1, 'asdf')")
    @db.execute("INSERT INTO Foo VALUES (1, 'zxcv')")
    rows = @db.execute("SELECT foobar FROM Foo;")
    
    assert_equal(3, rows.length)
    assert_equal('qwer', rows[0][0])
    assert_equal('asdf', rows[1][0])
    assert_equal('zxcv', rows[2][0])
  end
  def test__this_is_a_temp_test5
    @db.execute("INSERT INTO Foo VALUES (1, 'qwer')")
    @db.execute("INSERT INTO Foo VALUES (1, 'asdf')")
    @db.execute("INSERT INTO Foo VALUES (1, 'zxcv')")
    rows = @db.execute("SELECT foobar FROM Foo;")
    
    assert_equal(3, rows.length)
    assert_equal('qwer', rows[0][0])
    assert_equal('asdf', rows[1][0])
    assert_equal('zxcv', rows[2][0])
  end
  def test__this_is_a_temp_test4
    @db.execute("INSERT INTO Foo VALUES (1, 'qwer')")
    @db.execute("INSERT INTO Foo VALUES (1, 'asdf')")
    @db.execute("INSERT INTO Foo VALUES (1, 'zxcv')")
    rows = @db.execute("SELECT foobar FROM Foo;")
    
    assert_equal(3, rows.length)
    assert_equal('qwer', rows[0][0])
    assert_equal('asdf', rows[1][0])
    assert_equal('zxcv', rows[2][0])
  end
  def test__this_is_a_temp_test3
    @db.execute("INSERT INTO Foo VALUES (1, 'qwer')")
    @db.execute("INSERT INTO Foo VALUES (1, 'asdf')")
    @db.execute("INSERT INTO Foo VALUES (1, 'zxcv')")
    rows = @db.execute("SELECT foobar FROM Foo;")
    
    assert_equal(3, rows.length)
    assert_equal('qwer', rows[0][0])
    assert_equal('asdf', rows[1][0])
    assert_equal('zxcv', rows[2][0])
  end
  def test__this_is_a_temp_test2
    @db.execute("INSERT INTO Foo VALUES (1, 'qwer')")
    @db.execute("INSERT INTO Foo VALUES (1, 'asdf')")
    @db.execute("INSERT INTO Foo VALUES (1, 'zxcv')")
    rows = @db.execute("SELECT foobar FROM Foo;")
    
    assert_equal(3, rows.length)
    assert_equal('qwer', rows[0][0])
    assert_equal('asdf', rows[1][0])
    assert_equal('zxcv', rows[2][0])
  end
  def test__this_is_a_temp_test12
    @db.execute("INSERT INTO Foo VALUES (1, 'qwer')")
    @db.execute("INSERT INTO Foo VALUES (1, 'asdf')")
    @db.execute("INSERT INTO Foo VALUES (1, 'zxcv')")
    rows = @db.execute("SELECT foobar FROM Foo;")
    
    assert_equal(3, rows.length)
    assert_equal('qwer', rows[0][0])
    assert_equal('asdf', rows[1][0])
    assert_equal('zxcv', rows[2][0])
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

