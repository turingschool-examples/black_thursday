require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    se = SalesEngine.new

    assert_instance_of SalesEngine, se
  end

  def test_csv_is_read_for_merchant
    se = SalesEngine.new

    assert_equal "merchants.csv", se
  end

end
