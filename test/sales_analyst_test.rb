require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_analyst'
require 'simplecov'

SimpleCov.start

class SalesAnalystTest < Minitest::Test

  attr_reader :sa

  def setup
    se = SalesEngine.from_csv({:items => './test/fixtures/items_100.csv',
                               :merchants => './test/fixtures/merchants_100.csv'})
    @sa = SalesAnalyst.new(se)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, sa
  end

end