require_relative 'test_helper'
require_relative '../lib/sales_engine'
# require_relative 'merchant_repository'
# require_relative 'item_repository'
# require_relative 'merchant_repository'
# require_relative 'invoice_repository'
# require_relative 'invoice_item_repository'
# require_relative 'transaction_repository'
# require_relative 'customer_repository'

  # TODO Add isoloation test for CSV_IO

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
    assert_equal Merchant, se.merchants.all[0].class
  end

  def test_merchants_populates_merch_repo_with_all
    @se.merchants
    assert_equal 10, se.merchants.all.length
  end

  def test_merchants_repo_merch_objects_have_id
    @se.merchants
    assert_equal 12334299, se.merchants.all[1].id
  end

  def test_merchants_repo_merch_objs_have_name
    @se.merchants
    assert_equal "Shopin1901", se.merchants.all[0].name
  end

  def test_merchants_repo_merch_objs_have_ref_to_se
    @se.merchants
    assert_equal SalesEngine, se.merchants.all[9].sales_engine.class
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

  def test_invoices_makes_invoice_repo_object
    @se.invoices
    refute se.invoices.nil?
  end

  def test_invoices_populates_invoice_repo_with_invoice_objs
    @se.invoices
    assert_equal Invoice, se.invoices.all[0].class
  end

  def test_invoices_populates_invoice_repo_with_all
    @se.invoices
    assert_equal 10, se.invoices.all.length
  end

  def test_invoices_repo_invoice_objects_have_id
    @se.invoices
    assert_equal 2, se.invoices.all[1].id
  end

  def test_invoice_repo_invoice_objects_have_customer_id
    @se.invoices
    assert_equal 1, se.invoices.all[0].customer_id
  end

  def test_invoice_repo_item_objects_have_merchant_Id
    @se.invoices
    assert_equal 12335938, se.invoices.all[0].merchant_id
  end

  def test_invoice_repo_invoice_objects_have_status
    @se.invoices
    assert_equal "shipped", se.invoices.all[2].status
  end

  def test_invoice_repo_invoice_objs_have_created_at
    @se.invoices
    assert_equal Time.parse("2012-11-23"), se.invoices.all[1].created_at
  end

  def test_invoice_objs_have_created_by_as_time_obj
    @se.invoices
    assert_equal Time, se.invoices.all[1].created_at.class
  end

  def test_invoice_repo_item_objs_have_updated_at
    @se.invoices
    assert_equal Time.parse("2013-04-14"), se.invoices.all[1].updated_at
  end

  def test_invoice_objects_have_updated_at_as_time_obj
    @se.invoices
    assert_equal Time, se.invoices.all[1].updated_at.class
  end

  def test_invoice_objects_have_ref_to_se
    @se.invoices
    assert_equal SalesEngine, se.invoices.all[9].sales_engine.class
  end
  

end
