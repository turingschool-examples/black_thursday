require 'minitest/autorun'
require 'minitest/emoji'
require './lib/sales_engine.rb'
require './lib/sales_analyst.rb'
require 'pry'

class SalesAnalystTest < Minitest::Test

  def test_it_exists
    se = SalesEngine.from_csv({:items => './data/items.csv',
                               :merchants => './data/merchants.csv'})
    sa = SalesAnalyst.new(se)

    assert_instance_of SalesAnalyst, sa
  end

  def test_it_can_find_average_items_per_merchant
    se = SalesEngine.from_csv({:items => './data/items.csv',
                               :merchants => './data/merchants.csv'})
    sa = SalesAnalyst.new(se)

    target = sa.average_items_per_merchant

    assert_equal 2.88, target
  end

  def test_it_can_find_the_standard_deviation
    se = SalesEngine.from_csv({:items => './data/items.csv',
                               :merchants => './data/merchants.csv'})
    sa = SalesAnalyst.new(se)

    target = sa.average_items_per_merchant_standard_deviation

    assert_equal 3.26, target
  end

  def test_returns_array_of_items_per_merchant
    se = SalesEngine.from_csv({:items => './data/items.csv',
                               :merchants => './data/merchants.csv'})
    sa = SalesAnalyst.new(se)

    target = sa.number_of_items_per_merchant

    assert_equal 475, target.count
    assert_equal 3, target[0]
  end

  def test_it_returns_variance
    se = SalesEngine.from_csv({:items => './data/items.csv',
                               :merchants => './data/merchants.csv'})
    sa = SalesAnalyst.new(se)

    target = sa.get_variance([3, 4, 5])
    expected = [0.014400000000000026, 1.2544000000000002, 4.494400000000001]
    assert_equal expected, target
  end
end