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

end