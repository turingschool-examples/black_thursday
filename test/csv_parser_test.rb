require "minitest/autorun"
require "minitest/pride"
require "./lib/csv_parser"

class CsvParserTest < Minitest::Test

  def test_it_exists
    cp = CsvParser.new
    assert_instance_of CsvParser, cp
  end

  def test_opens_file
    cp = CsvParser.new
    file = cp.open_file('./test/fixtures/merchants_one.csv')
    assert_equal CSV, file.class
  end
end
