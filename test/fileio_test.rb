require_relative 'test_helper'
require_relative '../lib/fileio'

# Test for file io class
class FileIOTest < Minitest::Test
  def test_it_exists
    fileio = FileIO.new
    assert_instance_of FileIO, fileio
  end

  def test_it_gives_table
    path = './test/fixtures/test_merchants0.csv'
    assert_instance_of CSV::Table, FileIO.load(path)
  end
end
