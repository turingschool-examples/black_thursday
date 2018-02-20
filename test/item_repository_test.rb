# frozen_string_literal: true

require_relative 'test_helper'

require 'bigdecimal'
require_relative '../lib/item_repository'
require_relative '../lib/item'

class ItemReposityTest < Minitest::Test
  def setup
    @ir = ItemRepository.new './test/fixtures/items.csv'
  end

  def test_does_create_repository
    assert_instance_of ItemRepository, @ir
  end

  def test_did_load_items
    items = @ir.all
    assert_instance_of Array, items
    items.each do |item|
      assert_instance_of Item, item
    end

    assert_equal 'Desc A', items[0].description
  end
end
