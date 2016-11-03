require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  
  attr_reader :sales_engine

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
    assert_equal SalesEngine, sales_engine.class
  end  

  def test_it_intitalizes_an_item_repo_object
    assert_equal ItemRepository, sales_engine.items.class
  end

  def test_it_intitalizes_a_merch_repo_object
    assert_equal MerchantRepository, sales_engine.merchants.class
  end

  def test_find_items_by_merchant_id_finds_merchant
    expected = sales_engine.find_items_by_merchant_id(12334105)
    assert expected.all?{|item| item.class == Item}
    assert expected.all?{|item| item.merchant_id == 12334105}
  end

  def test_all_merchants_returns_array_of_all_merchants
    assert_equal Array, sales_engine.all_merchants.class
    assert sales_engine.all_merchants.all? { |merchant| merchant.class == Merchant}
    assert_equal sales_engine.merchants.all.count, sales_engine.all_merchants.count
  end

  def test_all_items_returns_array_of_all_items
    assert_equal Array, sales_engine.all_items.class
    assert sales_engine.all_items.all? { |item| item.class == Item}
    assert_equal sales_engine.items.all.count, sales_engine.all_items.count
  end

end