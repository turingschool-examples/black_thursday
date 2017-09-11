require "./test/test_helper"
require "./lib/sales_engine"
require "./lib/item_repository"
require "./lib/merchant_repository"

class SalesEngineTest < Minitest::Test
  attr_reader :se

  def setup
    @se = SalesEngine.new
  end

  def test_its_exists
    assert_instance_of SalesEngine, se
  end

  def test_it_gets_a_csv
  csv_hash = {
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
  }
    assert_equal "loaded", se.from_csv(csv_hash)
  end

  def test_items

    assert_instance_of ItemRepository, se.items
  end

  def test_merchants
    assert_instance_of MerchantRepository, se.merchants
  end 

end
