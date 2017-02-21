require_relative 'test_helper'
#require_relative '.../black_thursday_spec_harness'

class SalesEngineTest < Minitest::Test
  def test_it_exist
    se = SalesEngine.new("csv_file")
    assert_instance_of SalesEngine, se
  end

  def test_for_args
    se = SalesEngine.new({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv"})
  assert_equal ({:items     => "./data/items.csv",
  :merchants => "./data/merchants.csv"}), se.items
  end

  def test_that_csv_headers
      
  end
end
