require './test/test_helper'
require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/salesengine'

class SalesEngineTest < Minitest::Test

  def test_it_exists
    salesengine = SalesEngine.new({ :items     => "./data/items.csv",
                                    :merchants => "./data/merchants.csv",})

    assert_instance_of SalesEngine, salesengine
  end

  def test_items_returns_new_instance_of_item_repo
    salesengine = SalesEngine.new({ :items     => "./data/items.csv",
                                    :merchants => "./data/merchants.csv",})

    assert_instance_of ItemRepository, salesengine.items
  end

  def test_merchants_returns_new_instance_of_merchant_repo
    salesengine = SalesEngine.new({ :items     => "./data/items.csv",
                                    :merchants => "./data/merchants.csv",})


    assert_instance_of MerchantRepository, salesengine.merchants
  end

  def test_invoices_returns_new_instance_of_invoice_repo
    salesengine = SalesEngine.new({ :items     => "./data/items.csv",
                                    :merchants => "./data/merchants.csv",
                                    :invoices  => "./data/invoices.csv" })


    assert_instance_of InvoiceRepository, salesengine.invoices
  end

  def test_invoice_items_returns_new_instance_of_invoice_repo
    salesengine = SalesEngine.new({ :items         => "./data/items.csv",
                                    :merchants     => "./data/merchants.csv",
                                    :invoices      => "./data/invoices.csv",
                                    :invoice_items => "./data/invoice_items.csv"})

    assert_instance_of InvoiceItemRepository, salesengine.invoice_items
  end

  def test_transactions_returns_new_instance_of_transaction_repo
    salesengine = SalesEngine.new({ :items         => "./data/items.csv",
                                    :merchants     => "./data/merchants.csv",
                                    :invoices      => "./data/invoices.csv",
                                    :invoice_items => "./data/invoice_items.csv",
                                    :transactions  => "./data/transactions.csv"})

    assert_instance_of TransactionRepository, salesengine.transactions
  end

  def test_customers_returns_new_instance_of_customer_repo
    salesengine = SalesEngine.new({ :items         => "./data/items.csv",
                                    :merchants     => "./data/merchants.csv",
                                    :invoices      => "./data/invoices.csv",
                                    :invoice_items => "./data/invoice_items.csv",
                                    :transactions  => "./data/transactions.csv",
                                    :customers     => "./data/customers.csv"})

    assert_instance_of CustomerRepository, salesengine.customers
  end

end
