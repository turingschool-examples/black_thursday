require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require_relative '../lib/read_data.rb'

class ReadDataTest < Minitest::Test 
  def test_it_exists
    rd = ReadData.new     
    assert_instance_of ReadData, rd 
  end 
end 