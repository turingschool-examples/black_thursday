require 'minitest/autorun'
require './lib/csv_parser'

class CsvParserTest < Minitest::Test

  attr_reader :parser

  def setup
    @parser = CsvParser.new
  end

  def test_it_parses_merchant_csv_information
    assert_equal "", parser.merchant("./data/items.csv")
  end

end
