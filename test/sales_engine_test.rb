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

  def test_se_has_instances_child_classes
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
    # assert_instance_of InvoiceItemRepo, se.invoice_items
    # assert_instance_of CustomerRepo, se.customers
  end

  def test_item_merchant_can_be_found
    se = SalesEngine.from_csv({
      :items         => "./data/items.csv",
      :merchants     => "./data/merchants.csv",
      :invoices      => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv",
      :customers     => "./data/customers.csv"
    })

    assert_equal "jejum", se.find_merchant(12334141).name
    assert_equal 475, se.merchants.merchants.count
    assert_equal 1367, se.items.items.count
    assert_instance_of Merchant, se.merchants.merchants.first
    assert_instance_of Item, se.items.items.first
  end

end
