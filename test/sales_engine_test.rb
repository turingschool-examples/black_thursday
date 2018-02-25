require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def setup
    @data = {
      :items          => "./test/fixtures/items_sample.csv",
      :merchants      => "./test/fixtures/merchants_sample.csv",
      :invoices       => "./test/fixtures/invoices_sample.csv",
      :invoice_items  => "./test/fixtures/invoice_items_sample.csv",
      :transactions   => "./test/fixtures/transactions_sample.csv",
      :customers      => "./test/fixtures/customers_sample.csv"
        }
    @sales_engine = SalesEngine.new(@data)
  end

  def test_if_it_exists
    assert_instance_of SalesEngine, @sales_engine
  end

  def test_from_csv_method
    assert SalesEngine.from_csv(@data).items.class == ItemRepository
    assert SalesEngine.from_csv(@data).merchants.class == MerchantRepository
    assert SalesEngine.from_csv(@data).invoices.class == InvoiceRepository
    assert SalesEngine.from_csv(@data).invoice_items.class == InvoiceItemRepository
    assert SalesEngine.from_csv(@data).transactions.class == TransactionRepository
    assert SalesEngine.from_csv(@data).customers.class == CustomerRepository
  end

end
