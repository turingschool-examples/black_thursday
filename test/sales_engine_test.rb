require "minitest/autorun"
require "minitest/pride"
require_relative "../lib/sales_engine"
require "pry"

class SalesEngineTest < Minitest::Test
  def test_it_exists
    se = SalesEngine.new('dummy_variable', 'dummer_variable')

    assert_instance_of SalesEngine, se
  end
end
