require 'lib/fas_test'

class FasTestTests < FasTest::TestClass
    
  def test__asserting_equal_things_should_pass
    assert_equal(8, 8)
  end

  def test__asserting_true_thing_should_pass
    assert_true(true)
  end
  
end
