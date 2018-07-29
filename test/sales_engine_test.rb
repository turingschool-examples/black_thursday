require_relative 'test_helper'
require_relative '../lib/sales_engine.rb'

class SalesEngineTest < MiniTest::Test
  def setup
    merchant_1 = Merchant.new({
      name: "Bills Tools",
      id: "123",
      created_at: "2010-12-10",
      updated_at: "2011-12-04"
      })
    merchant_2 = Merchant.new({
      name: "Billys Tools",
      id: "124",
      created_at: "2010-12-10",
      updated_at: "2011-12-04"
      })
    merchant_3 = Merchant.new({
      name: "Bilbos Tools",
      id: "125",
      created_at: "2010-12-10",
      updated_at: "2011-12-04"
      })

    merchant_repository = [merchant_1, merchant_2, merchant_3]

    item_1 = Item.new({
      id: 4,
      name: "bottle",
      description: "holds water",
      unit_price: "700",
      updated_at: "2016-01-11",
      created_at: "2016-01-11",
      merchant_id: 90
      })
    item_2 = Item.new({
      id: 5,
      name: "paper",
      description: "write on it",
      unit_price: "100",
      updated_at: "2017-04-13",
      created_at: "2017-04-13",
      merchant_id: 90
      })
    item_3 = Item.new({
      id: 6,
      name: "tv",
      description: "watch stuff",
      unit_price: "25000",
      updated_at: "2016-11-11",
      created_at: "2016-11-11",
      merchant_id: 50
      })
    item_4 = Item.new({
      id: 7,
      name: "pencil",
      description: "writes things",
      unit_price: "300",
      updated_at: "2017-05-17",
      created_at: "2017-05-17",
      merchant_id: 50
      })

    item_repository = [item_1, item_2, item_3, item_4]

    invoice_1 = Invoice.new({
      id: 1,
      customer_id: 10,
      merchant_id: 123,
      status: "pending",
      created_at: "2004-02-17",
      updated_at: "2014-03-15"
      })
    invoice_2 = Invoice.new({
      id: 2,
      customer_id: 10,
      merchant_id: 124,
      status: "shipped",
      created_at: "2009-02-07",
      updated_at: "2012-03-15"
      })
    invoice_3 = Invoice.new({
      id: 3,
      customer_id: 12,
      merchant_id: 125,
      status: "returned",
      created_at: "1997-07-31",
      updated_at: "2014-02-11"
      })

    invoice_repository = [invoice_1, invoice_2, invoice_3]

    invoice_item_1 = InvoiceItem.new({
      id: 2345,
      item_id: 112,
      invoice_id: 522,
      unit_price: 84787,
      quantity: 5,
      created_at: "2012-03-27 14:54:35 UTC",
      updated_at: "2012-03-27 14:54:35 UTC"
      })
    invoice_item_2 = InvoiceItem.new({
      id: 2346,
      item_id: 113,
      invoice_id: 316,
      unit_price: 90000,
      quantity: 2,
      created_at: "2012-03-27 14:54:35 UTC",
      updated_at: "2012-03-27 14:54:35 UTC"
      })
    invoice_item_3 = InvoiceItem.new({
      id: 2347,
      item_id: 114,
      invoice_id: 222,
      unit_price: 100000,
      quantity: 1,
      created_at: "2012-03-27 14:54:35 UTC",
      updated_at: "2012-03-27 14:54:35 UTC"
      })
    invoice_item_4 = InvoiceItem.new({
      id: 2348,
      item_id: 115,
      invoice_id: 453,
      unit_price: 25397,
      quantity: 7,
      created_at: "2012-03-27 14:54:35 UTC",
      updated_at: "2012-03-27 14:54:35 UTC"
      })
    invoice_item_5 = InvoiceItem.new({
      id: 2349,
      item_id: 116,
      invoice_id: 846,
      unit_price: 11000,
      quantity: 5,
      created_at: "2012-03-27 14:54:35 UTC",
      updated_at: "2012-03-27 14:54:35 UTC"
      })

    invoice_item_repository = [invoice_item_1, invoice_item_2, invoice_item_3, invoice_item_4, invoice_item_5]

    transaction_1 = Transaction.new({
      id: 6,
      invoice_id: 9,
      credit_card_number: "4242424242424242",
      credit_card_expiration_date: "1020",
      result: "success",
      created_at: "1972-07-30 18:08:53 UTC",
      updated_at: "2016-01-11 18:30:35 UTC"
      })
    transaction_2 = Transaction.new({
      id: 7,
      invoice_id: 10,
      credit_card_number: "4242424275757575",
      credit_card_expiration_date: "1020",
      result: "success",
      created_at: "1972-07-30 18:08:53 UTC",
      updated_at: "2016-01-11 18:30:35 UTC"
      })
    transaction_3 = Transaction.new({
      id: 8,
      invoice_id: 9,
      credit_card_number: "8686868642424242",
      credit_card_expiration_date: "1020",
      result: "failed",
      created_at: "1972-07-30 18:08:53 UTC",
      updated_at: "2016-01-11 18:30:35 UTC"
      })

    transaction_repository = [transaction_1, transaction_2, transaction_3]

    customer_1 = Customer.new({
      id: 6,
      first_name: "Joan",
      last_name: "Clarke",
      created_at: "1972-07-30 18:08:53 UTC",
      updated_at: "2016-01-11 18:30:35 UTC"
      })
    customer_2 = Customer.new({
      id: 7,
      first_name: "Alan",
      last_name: "Turing",
      created_at: "1972-07-30 18:08:53 UTC",
      updated_at: "2016-01-11 18:30:35 UTC"
      })

    customer_repository = [customer_1, customer_2]

    @sales_engine = SalesEngine.new(merchant_repository, item_repository, invoice_repository, invoice_item_repository, transaction_repository, customer_repository)
  end

  def test_it_exists
    assert_instance_of SalesEngine, @sales_engine
  end

  def test_it_creates_repository_of_merchants
    assert_instance_of MerchantRepository, @sales_engine.merchants
  end

  def test_it_creates_repository_of_items
    assert_instance_of ItemRepository, @sales_engine.items
  end

  def test_it_creates_repository_of_invoices
    assert_instance_of InvoiceRepository, @sales_engine.invoices
  end

  def test_it_creates_repository_of_invoice_items
    assert_instance_of InvoiceItemRepository, @sales_engine.invoice_items
  end

  def test_it_creates_repository_of_transactions
    assert_instance_of TransactionRepository, @sales_engine.transactions
  end

  def test_it_creates_repository_of_customers
    assert_instance_of CustomerRepository, @sales_engine.customers
  end

  def test_it_creates_sales_analyst
    assert_instance_of SalesAnalyst, @sales_engine.analyst
  end
end
