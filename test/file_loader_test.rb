require './test/test_helper'
require './lib/file_loader'

class FileLoaderTest < Minitest::Test

  def test_returns_csv_object
    assert_instance_of CSV, FileLoader.load_csv("./data/items_test_data.csv")
  end

end
