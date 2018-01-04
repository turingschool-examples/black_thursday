require_relative "test_helper"
require_relative "../lib/sales_engine"

class SalesEngineTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    assert_instance_of SalesEngine, se
  end

  def test_it_has_merchants_and_items
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    assert_instance_of MerchantRepo, se.merchants
    assert_instance_of ItemRepo, se.items
    assert_equal 475, se.merchants.merchants.count
    assert_equal 1367, se.items.items.count
    assert_instance_of Merchant, se.merchants.merchants.first
    assert_instance_of Item, se.items.items.first
  end
end
