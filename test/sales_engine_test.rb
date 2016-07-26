gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require "./lib/sales_engine"


class SalesEngine < MiniTest::Test

  def test_it_can_load_a_csv

    assert_equal 0, se = SalesEngine.from_csv({
      :items => "./data/items.csv"})
  end


end
