require_relative 'test_helper'
require './lib/file_reader'

class FileReaderTest < Minitest::Test
  def setup
    @filereader = FileReader.new
  end

  def test_it_exists
    assert_instance_of FileReader, @filereader
  end

  def test_it_can_read_in_a_row

  end
end
