require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test
  attr_reader :se_hash, :se, :sa

  def setup
    @se_hash = {:items => './data/test_items.csv',
            :merchants => './data/test_merchant.csv'}
    @se = SalesEngine.new(se_hash)
    @sa = SalesAnalyst.new(se)
  end


  def test_for_instance_of_sales_analyst
    assert sa.instance_of?(SalesAnalyst)
  end

end
