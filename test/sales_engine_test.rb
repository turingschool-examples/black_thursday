require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/item_repository'
require_relative '../lib/merchant_repository'

# Test for the SalesEngine class
class SalesEngineTest < Minitest::Test
  def setup
    @sales_engine = SalesEngine.from_csv(
      items: './test/fixtures/test_items0.csv',
      merchants: './test/fixtures/test_merchants0.csv'
    )
  end

  def test_sales_engine_exists
    assert_instance_of SalesEngine, @sales_engine
  end

  def test_sales_engine_items_is_item_repo
    assert_instance_of ItemRepository, @sales_engine.items
  end

  def test_sales_engine_merchants_is_merchant_repo
    assert_instance_of MerchantRepository, @sales_engine.merchants
  end

  def test_sales_analyst_is_self_referential_analyst
    assert_instance_of SalesAnalyst, @sales_engine.analyst
  end
end
