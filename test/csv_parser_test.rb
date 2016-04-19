require './test/test_helper'
require 'minitest/autorun'
require './lib/csv_parser'

class CsvParserTest < Minitest::Test

  attr_reader :parser

  def setup
    @parser = CsvParser.new
  end

  def it_instantiates_parser
    assert parser
  end

  def test_it_parses_merchant_csv_into_array
    assert_equal Array, parser.merchants("./data/merchants.csv").class
  end

  def test_it_parses_each_merchant_into_hash
    assert_equal ({:id=>"12334105", :name=>"Shopin1901"}), parser.merchants("./data/merchants.csv")[0]
  end

  def test_it_parses_items_csv_into_array
    assert_equal Array, parser.items("./data/items.csv").class
  end



end
