require './test/test_helper'

class SalesEngineTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
    	  :items     => "./test/data/item_sample.csv",
    	  :merchants => "./test/data/merchant_sample.csv",
        :invoices  => "./test/data/invoice_test_data.csv",
        :invoice_items => "./test/data/invoice_item_sample.csv",
        :transactions => "./test/data/transaction_sample.csv",
        :customers => "./test/data/customer_sample.csv"
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

  def test_it_returns_transactions
    assert_instance_of TransactionRepository, @se.transactions
  end

  def test_it_returns_transactions
    assert_instance_of CustomerRepository, @se.customers
  end

end
