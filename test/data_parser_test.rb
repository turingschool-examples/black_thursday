require 'minitest/autorun'
require 'minitest/pride'
require './lib/data_parser'

class DataParserTest < Minitest::Test
  include DataParser
  def test_parsed_data_is_an_array
    assert_equal Array, parse_data('./data/merchants.csv').class
  end

  def test_parsed_data_contains_csv_objects
    assert_equal CSV::Row, parse_data('./data/merchants.csv')[0].class
  end
end
