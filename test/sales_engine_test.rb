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
    name = 'Glitter scrabble frames'
    string = 'Any colour glitter'

    assert_instance_of ItemRepository, se.items
    assert_instance_of Array, se.items.all
    assert_instance_of Item, se.items.find_by_name(name)
    assert_instance_of Item, se.items.find_by_id(1)
    assert_instance_of Item, se.items.find_all_with_description(string)[0]
    assert_equal [], se.items.find_all_by_price(1000.00)
    assert_instance_of Item, se.items.find_all_by_price_in_range((1..1000))[0]
    assert_equal [], se.items.find_all_by_merchant_id(12_345)
  end

  def test_initialize
    se = SalesEngine.new(items: './test/fixtures/items.csv')

    assert_instance_of SalesEngine, se
  end
end
