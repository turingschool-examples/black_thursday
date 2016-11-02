require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
      :items     => "./data/test_items.csv",
      :merchants => "./data/test_merchants.csv"
    })
  end
  
  def test_it_exists
    assert SalesEngine
  end

  def test_class_method_intializes_instance
    
  end  

  def test_it_intitalizes_an_item_repo_object
    assert_equal ItemRepository, @sales_engine.items.class
  end

  def test_it_intitalizes_a_merch_repo_object
    assert_equal MerchantRepository, @sales_engine.merchants.class
  end

end