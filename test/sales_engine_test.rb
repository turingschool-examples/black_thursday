require_relative 'test_helper'
require_relative '../lib/sales_engine'
require 'pry'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    se = SalesEngine.from_csv(items: './test/fixtures/items.csv')

    assert_instance_of SalesEngine, se
  end
end
