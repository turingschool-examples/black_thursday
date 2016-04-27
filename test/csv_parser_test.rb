# require_relative 'test_helper'
# require 'minitest/autorun'
# require_relative '../lib/csv_parser'
#
# class CsvParserTest < Minitest::Test
#
#   attr_reader :parser
#
#   def setup
#     @parser = CsvParser.new
#   end
#
#   def it_instantiates_parser
#     assert parser
#   end
#
#   def test_it_parses_merchant_csv_into_array
#     assert_equal Array, parser.merchants("./data/merchants.csv").class
#   end
#
#   def test_it_parses_each_merchant_into_hash
#     assert_equal "12334105", parser.merchants("./data/merchants.csv")[0][:id]
#   end
#
#   def test_it_parses_items_csv_into_array
#     assert_equal Array, parser.items("./data/items.csv").class
#   end
#
#   def test_it_parses_each_item_into_hash_and_finds_id
#     assert_equal "263395237", parser.items("./data/items.csv")[0][:id]
#   end
#
#   def test_it_parses_each_item_into_hash_and_finds_name
#     assert_equal "510+ RealPush Icon Set", parser.items("./data/items.csv")[0][:name]
#   end
#
# end
