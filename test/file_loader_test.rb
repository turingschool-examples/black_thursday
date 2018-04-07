# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/emoji'
require 'minitest/autorun'
require './lib/file_loader.rb'

# Test file for the FileLoader module.
class FileLoaderTest < MiniTest::Test
  def setup
    @f = Class.new { include FileLoader }.new
  end

  def test_it_can_read_from_csv_file
    csv_file = @f.load_file('./data/merchants.csv')
    expected = 'MiniatureBikez'
    actual = csv_file.readlines[2][:name]

    assert_equal expected, actual
  end
end
