require_relative 'test_helper'
require 'bigdecimal'
require './lib/item'

class ItemTest < Minitest::Test
  attr_reader :item
  def setup
    @item = Item.new({
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      })
  end

  def test_it_exists
    assert_instance_of Item, item
  end


end
