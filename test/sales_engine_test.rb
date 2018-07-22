require_relative 'test_helper'
require_relative '../lib/sales_engine.rb'

class SalesEngineTest < MiniTest::Test
  def setup
    @sales_engine = SalesEngine.from_csv({
                        :items     => "./data/items.csv",
                        :merchants => "./data/merchants.csv",
                      })
  end

  def test_it_exists
    assert_instance_of SalesEngine, @sales_engine
  end

  def test_it_creates_repository_of_merchants
    assert_instance_of MerchantRepository, @sales_engine.merchant_repo
  end

  def test_it_creates_repository_of_items
    assert_instance_of ItemRepository, @sales_engine.item_repo
  end

  def test_it_creates_sales_analyst
    assert_instance_of SalesAnalyst, @sales_engine.analyst
  end
end
