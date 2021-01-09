require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
                              items:      "./data/items.csv",
                              merchants:  "./data/merchants.csv",
                              invoices:   "./data/invoices.csv"
                              })
  end

  def test_it_exist_with_attributes
    assert_instance_of SalesEngine, @se
  end

  def test_sales_engine_can_build_repos

    assert_equal MerchantRepository, @se.merchants.class
    assert_equal ItemRepository, @se.items.class
    assert_equal InvoiceRepository, @se.invoices.class
  end
end
