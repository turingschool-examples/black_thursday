require './test/test_helper'
require './lib/sales_engine'
# require './test/merchant_repository'
# require './test/item_repository'
# require './test/merchant_repository'
# require './test/invoice_repository'
# require './test/invoice_item_repository'
# require './test/transaction_repository'
# require './test/customer_repository'


class SalesEngineTest < Minitest::Test

  attr_accessor :se

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/small_items.csv",
      :merchants => "./data/small_merchants.csv",})
  end

  def test_sales_engine_from_csv_creates_a_se_object
    assert_equal SalesEngine, se.class
  end

  def test_sales_engine_from_csv_stores_hash_as_ivar
      assert_equal ({
        :items     => "./data/small_items.csv",
        :merchants => "./data/small_merchants.csv"}), se.file_hash
  end

  def test_merchants_makes_merch_repo_object
    @se.merchants
    refute se.merchant_repository.nil?
  end

  def test_merchants_populates_merch_repo_with_merchants_objects
    @se.merchants
    assert_equal Merchant, se.merchant_repository.merchants[0].class
  end

  def test_merchants_populates_merch_repo_with_all_merchants
    @se.merchants
    assert_equal 10, se.merchant_repository.merchants.length
  end

  def test_merchants_repo_merch_objects_have_id
    @se.merchants
    assert_equal 12334112, se.merchant_repository.merchants[1].id
  end

  def test_merchants_repo_merch_objects_have_name
    @se.merchants
    assert_equal "Shopin1901", se.merchant_repository.merchants[0].name
  end

  def test_merchants_repo_merch_objects_have_ref_to_se
    @se.merchants
    assert_equal SalesEngine, se.merchant_repository.merchants[9].sales_engine.class
  end

end
