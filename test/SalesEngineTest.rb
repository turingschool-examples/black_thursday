require 'minitest/autorun'
require 'minitest/pride'
require './lib/SalesEngine'
require 'pry'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    se = SalesEngine.new

    assert_instance_of SalesEngine, se
  end
end 
