require 'minitest/autorun'
require 'minitest/emoji'
require_relative '../lib/salesanalyst'
require_relative '../lib/salesengine'
class SalesAnalystTest < Minitest::Test
  def setup
    {:items=>"./test/data/salesanalystsample.csv",:merchants=>"./data/merchantreposample.csv"}
  end

  def test_it_exists
    se = SalesEngine.from_csv(setup)
    sa = SalesAnalyst.new(se)

    assert_instance_of SalesAnalyst, sa
  end

  def test_retrieve_average_items_per_merchant
    se = SalesEngine.from_csv(setup)
    sa = SalesAnalyst.new(se)

    assert_equal 1.5 ,sa.average_items_per_merchant
  end

  def test_retrieve_average_items_per_merchant_standard_deviation
    se = SalesEngine.from_csv(setup)
    sa = SalesAnalyst.new(se)

    assert_equal 1.0 ,sa.average_items_per_merchant_standard_deviation
  end

  def test_retrieve_merchants_with_high_item_count
    se = SalesEngine.from_csv(setup)
    sa = SalesAnalyst.new(se)
    a = sa.merchants_with_high_item_count

    assert_equal 12334185 ,a[0]
  end

  def test_retrieve_average_item_price_for_merchant
    se = SalesEngine.from_csv(setup)
    sa = SalesAnalyst.new(se)

    assert_equal ,sa.average_item_price_for_merchant(12334185)
  end
end
