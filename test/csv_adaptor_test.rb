require_relative '../test/test_helper'
require_relative '../lib/csv_adaptor'

class CsvAdaptorTest < Minitest::Test
  
  def test_it_exists
    ca = CsvAdaptor.new

    assert_instance_of CsvAdaptor, ca
  end

  def test_it_returns_a_collection_of_objects
    csv_adaptor = CsvAdaptor.new

    actual = csv_adaptor.load_from_csv("./data/merchants.csv")
    expected_first = {id: 12334105, name: "Shopin1901", created_at: "2010-12-10", updated_at: "2011-12-04"}
    assert_equal 475, actual.length
    assert_equal expected_first, actual.first
  end
  
end