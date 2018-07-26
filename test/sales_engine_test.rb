require_relative 'test_helper'
require_relative '../lib/sales_engine.rb'

class SalesEngineTest < MiniTest::Test
  def setup
    @sales_engine = SalesEngine.from_csv({
                        :items     => "./data/items.csv",
                        :merchants => "./data/merchants.csv",
                        :invoices => "./data/invoices.csv",
                        :invoice_items => "./data/invoice_items.csv",
                        :transactions => "./data/transactions.csv"
                      })
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

  def test_it_creates_repository_of_items
    assert_instance_of InvoiceRepository, @sales_engine.invoices
  end

  def test_it_creates_repository_of_items
    assert_instance_of InvoiceItemRepository, @sales_engine.invoice_items
  end

  def test_it_creates_repository_of_items
    assert_instance_of TransactionRepository, @sales_engine.transactions
  end

  def test_it_creates_sales_analyst
    assert_instance_of SalesAnalyst, @sales_engine.analyst
  end
end
