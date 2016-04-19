require './test/test_helper'
# require './test/merchant_repository'
# require './test/item_repository'
# require './test/merchant_repository'
# require './test/invoice_repository'
# require './test/invoice_item_repository'
# require './test/transaction_repository'
# require './test/customer_repository'


class SalesEngineTest < Minitest::Test
  def test_sales_engine_from_csv_creates_a_se_object
    se = SalesEngine.from_csv({
      :items     => "./data/small_items.csv",
      :merchants => "./data/small_merchants.csv",})

    assert_equal SalesEngine, se.class
  end

  def test_sales_engine_from_csv_stores_hash_as_ivar
    se = SalesEngine.from_csv({
      :items     => "./data/small_items.csv",
      :merchants => "./data/small_merchants.csv"})

      assert_equal ({
        :items     => "./data/small_items.csv",
        :merchants => "./data/small_merchants.csv"}), se.file_hash
  end

end
