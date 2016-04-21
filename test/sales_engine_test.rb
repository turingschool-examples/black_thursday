require_relative 'test_helper'
require_relative '../lib/sales_engine'
# require_relative 'merchant_repository'
# require_relative 'item_repository'
# require_relative 'merchant_repository'
# require_relative 'invoice_repository'
# require_relative 'invoice_item_repository'
# require_relative 'transaction_repository'
# require_relative 'customer_repository'


class SalesEngineTest < Minitest::Test

  attr_accessor :se

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/small_items.csv",
      :merchants => "./data/small_merchants.csv",})
  end

  def test_sales_engine_from_csv_creates_se_object
    assert_equal SalesEngine, se.class
  end

  def test_sales_engine_from_csv_stores_ivar
    assert_equal ({
      :items     => "./data/small_items.csv",
      :merchants => "./data/small_merchants.csv"}), se.files
  end

  def test_merchants_makes_merch_repo_object
    @se.merchants
    refute se.merchants.nil?
  end

  def test_merchants_populates_merch_repo_with_merch_objs
    @se.merchants
    assert_equal Merchant, se.merchants.merchants[0].class
  end

  def test_merchants_populates_merch_repo_with_all
    @se.merchants
    assert_equal 10, se.merchants.merchants.length
  end

  def test_merchants_repo_merch_objects_have_id
    @se.merchants
    assert_equal 12334299, se.merchants.merchants[1].id
  end

  def test_merchants_repo_merch_objs_have_name
    @se.merchants
    assert_equal "Shopin1901", se.merchants.merchants[0].name
  end

  def test_merchants_repo_merch_objs_have_ref_to_se
    @se.merchants
    assert_equal SalesEngine, se.merchants.merchants[9].sales_engine.class
  end

  def test_items_makes_item_repo_object
    @se.items
    refute se.items.nil?
  end

  def test_items_populates_item_repo_with_item_objs
    @se.items
    assert_equal Item, se.items.items[0].class
  end

  def test_items_populates_item_repo_with_all
    @se.items
    assert_equal 19, se.items.items.length
  end

  def test_items_repo_item_objects_have_id
    @se.items
    assert_equal 263395721, se.items.items[1].id
  end

  def test_item_repo_item_objects_have_name
    @se.items
    assert_equal "Glitter scrabble frames", se.items.items[0].name
  end

  def test_item_repo_item_objects_have_desc
    @se.items
    assert_equal true, se.items.items[0].description.include?("Any colour glitter")
  end

  def test_item_repo_item_objects_have_price
    @se.items
    #why does this pass because its really a BD obj
    assert_equal 13.00, se.items.items[0].unit_price
  end

  def test_item_objs_have_price_as_big_decimal
    @se.items
    assert_equal BigDecimal, se.items.items[0].unit_price.class
  end

  def test_item_objs_have_price_as_float_when_transformed
    @se.items
    assert_equal Float, se.items.items[0].unit_price_to_dollars.class
  end

  def test_item_repo_item_objs_have_created_at
    @se.items
    assert_equal Time.parse("2016-01-11 11:51:37 UTC"), se.items.items[1].created_at
  end

  def test_item_objs_have_created_by_as_time_obj
    @se.items
    assert_equal Time, se.items.items[1].created_at.class
  end

  def test_item_repo_item_objs_have_updated_at
    @se.items
    assert_equal Time.parse("2008-04-02 13:48:57 UTC"), se.items.items[1].updated_at
  end

  def test_item_objects_have_updated_at_as_time_obj
    @se.items
    assert_equal Time, se.items.items[1].updated_at.class
  end

  def test_item_objects_have_ref_to_se
    @se.items
    assert_equal SalesEngine, se.items.items[9].sales_engine.class
  end


end
