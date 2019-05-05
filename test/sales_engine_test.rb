# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/emoji'
require 'minitest/autorun'
require './lib/sales_engine.rb'

class SalesEngineTest < MiniTest::Test

  def setup
    @s = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
  end

  def test_it_exists
    assert_instance_of SalesEngine, @s
  end

  def test_it_can_load_items
    expected = 'Puppy blankie'
    actual = @s.items.find_by_id(263538760).name

    assert_equal expected, actual
  end

  def test_it_can_return_items_based_on_merchant_id
    item = @s.items.find_by_id(263538760)
    expected = item.merchant.name
    actual = 'Blankiesandfriends'

    assert_equal expected, actual
  end

  def test_it_can_return_merchant_based_on_item_id
    merchant = @s.merchants.find_by_id(12335971)
    expected = merchant.items.first.id
    actual = 263544502

    assert_equal expected, actual
  end
end
