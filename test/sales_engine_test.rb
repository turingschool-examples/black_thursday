require './test/test_helper'

class SalesEngineTest < Minitest::Test
  def setup
    item_path          = "./data/items.csv"
    merchant_path      = "./data/merchants.csv"
    invoice_path       = "./data/invoices.csv"
    invoice_item_path  = "./data/invoice_items.csv"
    customer_path      = "./data/customers.csv"
    transaction_path   = "./data/transactions.csv"
    arguments = {
                  :items     => item_path,
                  :merchants => merchant_path,
                  :invoices  => invoice_path,
                  :invoice_items => invoice_item_path,
                  :customers     => customer_path,
                  :transactions => transaction_path
                }
    @se = SalesEngine.from_csv(arguments)
    @ir = @se.items
    @mr = @se.merchants
    @invrepo = @se.invoices
    @invitem = @se.invoice_items
    @customers = @se.customers
    @transactions = @se.transactions

  end

  def test_it_exists
    assert_instance_of SalesEngine, @se
  end

  def test_fomr_csv_initializes_several_repositories
    assert_instance_of ItemRepository, @ir
    assert_instance_of MerchantRepository, @mr
    assert_instance_of InvoiceRepository, @invrepo
    assert_instance_of InvoiceItemRepository, @invitem
    assert_instance_of CustomerRepository, @customers
    assert_instance_of TransactionRepository, @transactions
  end
end
