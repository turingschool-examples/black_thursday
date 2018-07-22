require_relative './test_helper'
require './lib/file_loader'

class FileLoaderTest < Minitest::Test

  def test_it_exists
    fl = FileLoader.new('file')

    assert_instance_of FileLoader, fl
  end

end
