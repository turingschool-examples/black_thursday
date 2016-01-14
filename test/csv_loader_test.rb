require 'minitest/autorun'
require 'minitest/pride'
require './lib/csv_loader'

class CsvLoaderTest < Minitest::Test

include CsvLoader

  def test_csv_loader_loads_an_instance_of_csv_file
    assert_equal CSV, load_data('./data/test_items.csv').class
  end

  def test_csv_loader_returns_csv_rows
    data = load_data('./data/test_items.csv')

    data.each do |row|
      assert_equal CSV::Row, row.class
    end
  end
end
