 


class SalesEngineTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.new

    assert_instance_of SalesEngine, se
  end

  def test_it_initializes_new_items
    se = SalesEngine.new

    assert_instance_of Items, se.items
  end

  def test_it_initializes_new_merchants
    se = SalesEngine.new

    assert_instance_of Merchants, se.merchants
  end

end
