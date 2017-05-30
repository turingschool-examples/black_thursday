require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'

class SalesEngineTest < MiniTest::Test

  def test_if_create_class
    se = SalesEngine.new

    assert_instance_of SalesEngine, se
  end



end
