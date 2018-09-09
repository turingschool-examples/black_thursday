require 'minitest/autorun'
require 'minitest/pride'
require './lib/SalesEngine'
require 'pry'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    se = SalesEngine.new

    assert_instance_of SalesEngine, se
  end

  def test_it_can_initialize_from_csv
    se = SalesEngine.from_csv()
end
