require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/salesengine'


class SalesEngineTest < Minitest::Test

  def test_it_exist
    salesengine = SalesEngine.new

    assert_instance_of SalesEngine, salesengine
  end




end
