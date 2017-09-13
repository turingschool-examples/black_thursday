require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'


class SalesEngineTest < Minitest::Test
  def test_it_exists
    sales = SalesEngine.new

    assert_instance_of SalesEngine, sales
  end

  def test_from_csv_item
    sales = SalesEngine
    assert_instance_of ItemRepository, sales.read_items_file("./data/item_fixture.csv")
  end

  def test_from_csv_merchants
    sales = SalesEngine
    assert_instance_of MerchantRepository, sales.read_merchants_file("./data/merchant_test_helper.csv")
  end

end
