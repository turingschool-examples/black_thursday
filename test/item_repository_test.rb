require './test/test_helper'
require 'minitest/autorun'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  attr_reader :i

  def setup
    @i = Item.new({
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
    })
  end

  def test_it_can_give_a_name
    assert_equal "", i.name
  end
end
