require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require 'pry'

class SalesEngineTest < Minitest::Test
  def test_that_it_exists
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :customers => "./data/customers.csv",
    :transactions => "./data/transactions.csv"
    })
    assert_instance_of SalesEngine, se
  end

  def test_that_it_has_attributes
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :customers => "./data/customers.csv",
    :transactions => "./data/transactions.csv"
    })

    assert_instance_of ItemRepository, se.items
    assert_instance_of MerchantRepository, se.merchants
    assert_instance_of InvoiceRepository, se.invoices
    assert_instance_of InvoiceItemRepository, se.invoice_items
    assert_instance_of TransactionRepository, se.transactions
    assert_instance_of CustomerRepository, se.customers
  end

  def test_that_merchant_passes_an_array_of_merchants_to_mr
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :customers => "./data/customers.csv",
    :transactions => "./data/transactions.csv"
    })
    mr = se.merchants
    actual = mr.merchants_array[0]

    assert_instance_of Merchant , actual
  end

  def test_that_items_obtains_array_of_item_hashes
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :customers => "./data/customers.csv",
    :transactions => "./data/transactions.csv"
    })
    ir = se.items
    actual = ir.all[0]

    assert_instance_of Item , actual
  end

  def test_that_invoices_obtains_array_of_invoices
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :customers => "./data/customers.csv",
    :transactions => "./data/transactions.csv"
    })
    inv = se.invoices
    actual = inv.all[0]

    assert_instance_of Invoice , actual
  end

  def test_that_invoice_items_obtains_array_of_invoice_items
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :customers => "./data/customers.csv",
    :transactions => "./data/transactions.csv"
    })
    inv_items = se.invoice_items
    actual = inv_items.all[0]

    assert_instance_of InvoiceItem , actual
  end

  def test_that_transactions_obtains_array_of_transactions
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :customers => "./data/customers.csv",
    :transactions => "./data/transactions.csv"
    })
    transactions = se.transactions
    actual = transactions.all[0]

    assert_instance_of Transaction , actual
  end

  def test_that_items_obtains_array_of_item_hashes
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/invoice_items.csv",
    :customers => "./data/customers.csv",
    :transactions => "./data/transactions.csv"
    })
    customers = se.customers
    actual = customers.all[0]

    assert_instance_of Customer , actual
  end
end
