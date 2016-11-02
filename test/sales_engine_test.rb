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
    assert_equal SalesEngine, @sales_engine.class
  end  

  def test_it_intitalizes_an_item_repo_object
    assert_equal ItemRepository, @sales_engine.items.class
  end

  def test_it_intitalizes_a_merch_repo_object
    assert_equal MerchantRepository, @sales_engine.merchants.class
  end

  def test_find_items_by_merchant_id_finds_merchant
    expected = @sales_engine.find_items_by_merchant_id(12334105)
    assert expected.all?{|item| item.class == Item}
    assert expected.all?{|item| item.merchant_id == 12334105}
  end

end