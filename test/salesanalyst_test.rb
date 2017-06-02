require 'minitest/autorun'
require 'minitest/emoji'
require_relative '../lib/salesanalyst'
require_relative '../lib/salesengine'
class SalesAnalystTest < Minitest::Test
  def test_it_exists
    se = SalesEngine.from_csv({:items=>"./test/data/salesanalystsample.csv",:merchants=>"./data/merchants.csv"})
    sa = SalesAnalyst.new(se)

    assert_instance_of SalesAnalyst, sa
  end

  def test_retrieve_average_items_per_merchant
    se = SalesEngine.from_csv({:items=>"./test/data/salesanalystsample.csv",:merchants=>"./data/merchants.csv"})
    sa = SalesAnalyst.new(se)

    assert_equal 1.5 ,sa.average_items_per_merchant
  end

  def test_retrieve_average_items_per_merchant_standard_deviation
    se = SalesEngine.from_csv({:items=>"./test/data/salesanalystsample.csv",:merchants=>"./data/merchants.csv"})
    sa = SalesAnalyst.new(se)

    assert_equal ,sa.average_items_per_merchant_standard_deviation
  end
end
