require './test/test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  attr_reader :sales_engine
  def setup
    @sales_engine = SalesEngine.from_csv(
      items: './data/items.csv',
      merchants: './data/merchants.csv'
    )
  end

  def test_it_exists
    assert_instance_of SalesEngine, sales_engine
  end

  def test_it_has_child_instances
    assert_instance_of ItemRepository, sales_engine
    assert_instance_of MerchantRepository, sales_engine
  end
end
