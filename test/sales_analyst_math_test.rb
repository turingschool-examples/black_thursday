require "./test/test_helper"
require "./lib/sales_engine"
require "./lib/sales_analyst"
require "./lib/item_repository"
require "./lib/merchant_repository"
require "./lib/merchant"
require "./lib/item"


class TestSalesAnalystMath < Minitest::Test

  attr_reader :sa, :mod, :merchants_and_things, :things

  def setup
    csv_hash = {
      :items     => "./test/test_fixtures/items_medium.csv",
      :merchants => "./test/test_fixtures/merchants_medium.csv",
      :invoices => ".//test/test_fixtures/invoices_medium.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./test/test_fixtures/transactions_medium.csv",
      :customers => "./test/test_fixtures/customers_medium.csv"
    }
    sales_engine = SalesEngine.from_csv(csv_hash)
    @sa = SalesAnalyst.new(sales_engine)
    @mod = SalesAnalystMath
    @things = sales_engine.invoices
    @merchants_and_things = sa.make_merchants_and_things(things)
  end


  def test_it_exists
    assert_instance_of Module, mod
  end

  def test_its_exists
    assert_instance_of SalesAnalyst, sa
  end

  def test_it_makes_merchant_hash
    assert_instance_of Hash, sa.make_merchants_and_things(things)
  end

  def test_average_things_per_merchant
    assert_equal 5.07, sa.average_things_per_merchant(merchants_and_things)
  end

  def test_average_things_per_merchant_standard_deviation
    assert_equal 2.23, sa.average_things_per_merchant_standard_deviation(merchants_and_things)
  end


end
