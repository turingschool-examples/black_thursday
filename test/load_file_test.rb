require_relative 'test_helper'
require_relative '../lib/load_file'

class LoadFileTest < Minitest::Test

  def test_it_exists
    assert_instance_of LoadFile, LoadFile.new
  end

  def test_it_loads_csv_by_line
    file_name = "./test/fixture_data/item_fixture.csv"
    actual = LoadFile.load(file_name)
    assert_instance_of CSV, actual
  end
end