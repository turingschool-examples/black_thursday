require_relative 'test_helper.rb'
require './lib/csv_parser'
require 'pry'

class CsvParcerTest < Minitest::Test
  def test_it_exists
    csv = CsvParser.new
    assert_instance_of(CsvParser, csv)
  end

  def test_it_loads_a_file
    csv = CsvParser.new
    assert_equal CSV::Table, csv.load_csv('./data/merchants.csv').class
    binding.pry
  end

  def test_file_is_correct_file
    csv = CsvParser.new
    csv.load_csv('./data/merchants.csv')
    assert_equal "Shopin1901", csv.csv_file[0][:name]
  end
end
