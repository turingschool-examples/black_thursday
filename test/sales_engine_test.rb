

require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test

  def setup
    @engine = SalesEngine.from_csv({:merchants => "./data/merchants_tiny.csv"})
  end

  def test_it_can_create_new_instance_of_csv_file
    skip
    assert_instance_of SalesEngine, @engine
  end

  def test_me
    skip
    assert_equal 475, @engine.merchants.all
  end
end

