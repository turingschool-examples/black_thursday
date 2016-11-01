require_relative 'test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  
  def test_it_exists
    assert SalesEngine
  end

  def test_it_intitalizes_an_item_repo_object
    SalesEngine.from_csv({
      :items     => "./data/test_items.csv",
      :merchants => "./data/test_merchants.csv",
    })
    assert_equal ItemRepository, SalesEngine.items.class
  end

  def test_it_intitalizes_a_merch_repo_object
    SalesEngine.from_csv({
      :items     => "./data/test_items.csv",
      :merchants => "./data/test_merchants.csv",
    })
    assert_equal MerchantRepository, SalesEngine.merchants.class
  end

  

end
