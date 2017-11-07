require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    files = ({:invoices => "./test/fixture/invoice_fixture.csv",
      :items => "./test/fixture/item_fixture.csv",
      :merchants => "./test/fixture/merchant_fixture.csv",
      :invoice_items => "./test/fixture/invoice_item_fixture.csv",
      :transactions => "./test/fixture/transaction_fixture.csv",
      :customers => "./test/fixture/customer_fixture.csv"})
    SalesEngine.from_csv(files)
  end

  def test_it_exists
    assert_instance_of SalesEngine, setup
  end

  def test_item_repo_is_pulled_in
    assert_instance_of ItemRepository, setup.items
  end

  def test_merch_repo_is_pulled_in
    assert_instance_of MerchantRepository, setup.merchants
  end

  def test_find_merchant_items_things
    assert_equal 3, setup.find_merchant_items(12334185).count
  end

  def test_find_item_merchants
    assert_equal 12334115, setup.find_item_merchant(12334115).id
  end

  def test_find_invoices_for_merchants
    assert_equal 1, setup.find_merchant_invoices(12334123).count
  end

  def test_it_can_find_merchant_by_invoice
    assert_equal 12334115, setup.find_invoice_for_merchants(12334115).id
  end

  def test_it_finds_items_for_invoices
    assert_instance_of Item, setup.find_items_for_invoices(6)[0]
    assert_equal 6, setup.find_items_for_invoices(6).count
  end

  def test_find_transactions_for_invoice
    assert_instance_of Transaction, setup.find_transactions_for_invoice(46).first
  end

  def test_find_customer_from_invoice
    assert_instance_of Customer, setup.find_customer_from_invoice(9)
  end

  def test_find_invoice_for_transaction
    assert_instance_of Invoice, setup.find_invoice_for_transaction(46)
  end

  def test_find_invoice_for_merchant
    assert_instance_of Invoice, setup.find_all_invoices_for_merchant(12334389).first
  end

  def test_find_merchant_customers
    files = ({:invoices => "./data/invoices.csv",
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"})
    se = SalesEngine.from_csv(files)
    assert_instance_of Customer, se.find_merchant_customer(12334115).first
  end

  def test_find_merchant_ids_from_invoices
    assert_equal 12335955, setup.find_merchant_ids_from_invoice(3).first
  end

  def test_find_all_invoices_for_customer
    assert_instance_of Invoice, setup.find_all_invoices_for_merchant(12334389).first
  end

  def test_find_merchant_ids_from_customer_invoice
    assert_equal 12335955, setup.find_merchant_ids_from_invoice(3).first
  end

  def test_find_customer_merchants
    files = ({:invoices => "./data/invoices.csv",
      :items => "./test/fixture/item_fixture.csv",
      :merchants => "./data/merchants.csv",
      :invoice_items => "./test/fixture/invoice_item_fixture.csv",
      :transactions => "./test/fixture/transaction_fixture.csv",
      :customers => "./data/customers.csv"})
    se = SalesEngine.from_csv(files)
    assert_instance_of Merchant, se.find_customer_merchant(5).first
  end

end
