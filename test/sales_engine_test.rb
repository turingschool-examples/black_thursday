require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :customers => "./data/customers.csv",
      :transactions => "./data/transactions.csv"
    })

    assert_instance_of SalesEngine, se
  end

  def test_it_has_repositories
    se = SalesEngine.from_csv({
        :items => "./data/items.csv",
        :merchants => "./data/merchants.csv",
        :invoices => "./data/invoices.csv",
        :invoice_items => "./data/invoice_items.csv",
        :customers => "./data/customers.csv",
        :transactions => "./data/transactions.csv"
      })

      ir = se.items
      mr = se.merchants
      inr = se.invoices
      iir = se.invoice_items
      cr = se.customers
      tr = se.transactions
      assert_instance_of MerchantRepository, mr
      assert_instance_of ItemRepository, ir
      assert_instance_of InvoiceRepository, inr
      assert_instance_of InvoiceItemRepository, iir
      assert_instance_of CustomerRepository, cr
      assert_instance_of TransactionRepository, tr
  end
end
