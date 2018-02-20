require './test/test_helper'
require './lib/sales_engine'
require 'pry'

# Tests Sales Engine class
class SalesEngineTest < Minitest::Test
  def setup
    @sales_eng = SalesEngine.from_csv(
      items:     './data/sample_data/items.csv',
      merchants: './data/sample_data/merchants.csv'
    )
  end

  def test_sales_engine_class_exists
    assert_instance_of SalesEngine, @sales_eng
  end

  def test_sales_engine_creates_instances_of_repositories
    assert_instance_of ItemRepository, @sales_eng.items
    assert_instance_of MerchantRepository, @sales_eng.merchants
  end
end
