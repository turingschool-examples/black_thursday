require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @sales_engine = SalesEngine.from_csv({
                              items:      "./data/items.csv",
                              merchants:  "./data/merchants.csv",
                              invoices:   "./data/invoices.csv"
                              })
  end

  def test_it_exist_with_attributes
    assert_instance_of SalesEngine, @sales_engine
  end

  def test_sales_engine_can_build_repos

    assert_equal MerchantRepository, @sales_engine.merchants.class
    assert_equal ItemRepository, @sales_engine.items.class
    assert_equal InvoiceRepository, @sales_engine.invoices.class
  end

  def test_it_creates_new_analyst
    assert_instance_of SalesAnalyst, @sales_engine.analyst
  end

  def test_it_finds_merchant_items
    assert_equal 3, @sales_engine.merchant_items(12334105).length
    assert_equal "Vogue Patterns/Patron 9712", @sales_engine.merchant_items(12334105)[2].name
  end
end
