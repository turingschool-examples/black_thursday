require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def setup
    @data = {
      :items     => "./test/fixtures/items_sample.csv",
      :merchants => "./test/fixtures/merchants_sample.csv",
      :invoices => "./test/fixtures/invoices_sample.csv"
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
  end

end
