require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repo'
require_relative '../lib/item_repo'

class SalesEngineTest < Minitest::Test
  def set_up
    files = ({:invoices => "./test/fixtures/invoice_fixture.csv", :items => "./test/fixtures/item_fixture.csv", :merchants => "./test/fixtures/merchant_fixture.csv", :invoice_items => "./test/fixtures/invoice_items_fixture.csv", :transactions => "./test/fixtures/transactions_fixture.csv", :customers => "./test/fixtures/customers_fixture.csv"})
    SalesEngine.from_csv(files)
  end

  def test_it_exists
    assert_instance_of SalesEngine, set_up
  end

  def test_from_csv_item
    assert_instance_of ItemRepository, set_up.items
  end

  def test_from_csv_merchants
    assert_instance_of MerchantRepository, set_up.merchants
  end

  def test_it_has_merchant_items
    assert_equal 1, set_up.find_merchant_items(12334105).count
  end

  def test_find_merchant_invoice
    assert_equal 1, set_up.find_merchant_invoice(12334115).count
  end

  def test_find_invoice_for_merchant
    assert_instance_of Merchant , set_up.find_invoice_for_merchant(12334115)
  end

  def test_find_merchant_items
    assert_instance_of Item, set_up.find_merchant_items(12334105).first
  end

  def test_find_item_merchant
    assert_instance_of Merchant, set_up.find_item_merchant(12334105)
  end

  def test_find_items_for_invoices
    files = ({:invoices => "./data/invoices.csv", :items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoice_items => "./data/invoice_items.csv", :transactions => "./data/transactions.csv", :customers => "./data/customers.csv"})
    se = SalesEngine.from_csv(files)

    assert_instance_of Item, se.find_items_for_invoices(1).first
  end

  def test_find_transactions_for_invoice
    assert_instance_of Transaction, set_up.find_transactions_for_invoice(46).first
  end

  def test_find_customer_from_invoice
    assert_instance_of Customer, set_up.find_customer_from_invoice(9)
  end

  def test_find_invoice_for_transaction
    assert_instance_of Invoice, set_up.find_invoice_for_transaction(46)
  end

  def test_find_merchant_customer
    files = ({:invoices => "./data/invoices.csv", :items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoice_items => "./data/invoice_items.csv", :transactions => "./data/transactions.csv", :customers => "./data/customers.csv"})
    se = SalesEngine.from_csv(files)

    assert_instance_of Customer, se.find_merchant_customer(12334115).first
  end

  def test_find_customer_merchant
    files = ({:invoices => "./data/invoices.csv", :items => "./data/items.csv", :merchants => "./data/merchants.csv", :invoice_items => "./data/invoice_items.csv", :transactions => "./data/transactions.csv", :customers => "./data/customers.csv"})
    se = SalesEngine.from_csv(files)

    assert_instance_of Merchant, se.find_customer_merchant(2).first
  end

end
