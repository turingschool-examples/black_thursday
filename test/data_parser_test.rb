require 'minitest/autorun'
require 'minitest/pride'
require './lib/data_parser'

class DataParserTest < Minitest::Test
  def test_parsed_data_is_an_array
    assert_equal Array, DataParser.parse_data('./data/merchants.csv').class
  end

  def test_parsed_data_contains_csv_objects
    assert_equal CSV::Row, DataParser.parse_data('./data/merchants.csv')[0].class
  end
end
