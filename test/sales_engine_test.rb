require './test/test_helper'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
    	  :items     => "./data/items.csv",
    	  :merchants => "./data/merchants.csv",
        :invoices  => "./data/invoices.csv",
        :invoice_items => "./data/invoice_items.csv",
        :transactions => "./test/data/transaction_sample.csv"
    	})
  end

  def test_it_exists
    assert_instance_of SalesEngine, @se
  end

  def test_it_returns_items
    assert_instance_of ItemRepository, @se.items
  end

  def test_it_returns_merchants
    assert_instance_of MerchantRepository, @se.merchants
  end

  def test_it_returns_invoices
    assert_instance_of InvoiceRepository, @se.invoices
  end

  def test_it_returns_invoice_items
    assert_instance_of InvoiceItemRepository, @se.invoice_items
  end

  def test_it_returns_invoice_items
    assert_instance_of TransactionRepository, @se.transactions
  end

end
