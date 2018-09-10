require_relative './test_helper'
require_relative '../lib/modules/csv_adapter'


class CSVAdapterTest < Minitest::Test
  def setup
    @test_obj = Object.new
    @test_obj.extend(CSVAdapter)
  end

  def test_it_can_get_hash_from_csv_file
    file = "./test/data/items.csv"
    data = @test_obj.hash_from_csv(file)

    expected = "17000"
    # TODO: Update to expect 'data' as an array of hashes instead of a hash of
    # hashes
    assert_equal expected, data[263400793][:unit_price]
  end
end
