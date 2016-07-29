require './test/test_helper'
require './lib/sales_analyst'
require './lib/sales_engine'

class SalesAnalystTest < Minitest::Test
  attr_reader :sa

  def setup
    se = SalesEngine.from_csv({
      :items     => "./test/fixtures/items_fixture.csv",
      :merchants => "./test/fixtures/merchants_fixture.csv",
    })
    @sa = SalesAnalyst.new(se)
  end

  def test_has_sales_engine
    assert_instance_of SalesEngine, sa.engine
  end

  def test_method_average_items_per_merchant_returns_float
    merchant_ids = sa.engine.merchants.merchants.map{ |m| m.id }
    items_per_merchant = merchant_ids.map do |id|
      sa.engine.find_all_items_by_merchant_id(id).length
    end
    total_items_per_merchant = items_per_merchant.reduce(:+)
    total_merchants = merchant_ids.length
    answer = (total_items_per_merchant.to_f / total_merchants.to_f)
    assert_equal answer, sa.average_items_per_merchant
  end

end
