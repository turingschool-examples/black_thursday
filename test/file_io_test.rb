require_relative 'test_helper'
require_relative '../lib/file_io'

# Test for file io class
class FileIOTest < Minitest::Test
  def test_it_exists
    file_io = FileIO.new
    assert_instance_of FileIO, file_io
  end

  def test_it_gives_table
    path = './test/fixtures/test_merchants0.csv'
    assert_instance_of CSV::Table, FileIO.load(path)
  end
end
