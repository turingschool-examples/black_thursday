require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
  def setup
    @se = SalesEngine.new
  end

  def test_it_exists
    assert_instance_of SalesEngine, @se
  end

  def test_

  end
end
