require_relative 'test_helper'
require_relative '../lib/sales_engine'
require 'pry'

class SalesEngineTest < Minitest::Test
  def test_it_exists
    se = SalesEngine.from_csv(items: './test/fixtures/items.csv')

    assert_instance_of SalesEngine, se
  end

  def test_it_has_repos
    se = SalesEngine.from_csv(items: './test/fixtures/items.csv')

    assert_instance_of ItemRepository, se.items
  end
end
