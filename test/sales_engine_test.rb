require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    sales = SalesEngine.new

    assert_instance_of SalesEngine, sales
  end

  def test_instance_of_items_repo
    sales = SalesEngine.new

    assert_instance_of ItemRepository, sales.items
  end

  def test_instance_of_merchant_repo
    sales = SalesEngine.new

    assert_instance_of MerchantRepository, sales.merchants
  end

  def test_from_csv_items
    sales = SalesEngine.new
    sales.from_csv({:items => "./data/item_fixture"})

    assert_equal 10, sales.items.items
  end

end
