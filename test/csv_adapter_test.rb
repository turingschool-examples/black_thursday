require_relative '../test/test_helper'
require_relative '../lib/csv_adapter'

class CsvAdapterTest < Minitest::Test

  def test_it_exits
    ca = CsvAdapter.new
    assert_instance_of CsvAdapter, ca
  end

  def test_it_returns_a_hash
    ca = CsvAdapter.new
    actual = ca.load
    expected = {
          :items     => "./data/items.csv",
          :merchants => "./data/merchants.csv"
        }
    assert_equal expected, actual
  end

end
