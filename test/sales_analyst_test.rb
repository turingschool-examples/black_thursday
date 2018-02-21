require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require_relative 'mocks/test_engine'

class SalesAnalystTest < Minitest::Test
  def setup
    @sa = SalesAnalyst.new MOCK_SALES_ENGINE
  end

  def test_does_create_sales_analyst
    assert_instance_of SalesAnalyst, @sa
  end

  def test_does_have_sales_engine
    assert_instance_of SalesEngine, @sa.sales_engine
  end
end
