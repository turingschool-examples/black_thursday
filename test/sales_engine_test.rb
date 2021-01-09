require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require './lib/sales_analyst'
require 'csv'

class SalesEngineTest < Minitest::Test
  def test_it_exists_and_has_attributes
    merchant_path = './data/merchants.csv'
    item_path = './data/items.csv'
    locations = { items: item_path,
                  merchants: merchant_path }

    se = SalesEngine.from_csv(locations)
    assert_instance_of SalesEngine, se
  end

  def test_it_creates_sales_analyst
    merchant_path = './data/merchants.csv'
    item_path = './data/items.csv'
    locations = { items: item_path,
                  merchants: merchant_path }

    sales_engine = SalesEngine.from_csv(locations)
    assert_instance_of SalesAnalyst, sales_engine.analyst
  end
end
