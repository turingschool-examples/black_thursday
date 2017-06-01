require 'minitest/autorun'
require 'minitest/emoji'
require_relative '../lib/salesanalyst'
class SalesAnalystTest < Minitest::Test
  def test_it_exists
    se = SalesEngine.from_csv({:items=>"./test/itemreposample.csv",:merchants=>"./test/merchantreposample.csv"})
    sa = SalesAnalyst.new

    assert_instance_of SalesAnalyst, sa
  end

  def test_retrieve_average_items_per_merchant
    se = SalesEngine.from_csv({:items=>"./test/itemreposample.csv",:merchants=>"./test/merchantreposample.csv"})
    sa = SalesAnalyst.new(se)

    assert_equal ,sa.average_items_per_merchant

  end
end
