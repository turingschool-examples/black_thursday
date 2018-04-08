require_relative 'test_helper'
require_relative '../lib/fileio'
require_relative 'fixtures/test_merchants.csv'

# Test for file io class
class FileIOTest < Minitest::Test
  def test_it_exists
    fileio = FileIO.new
    assert_instance_of FileIO, fileio
  end

  def test_it_gives_array
    assert_instance_of Array, FileIO.load('fixtures/test_merchants.csv')
  end
end
