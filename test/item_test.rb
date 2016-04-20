require_relative 'test_helper'
require 'minitest/autorun'
require_relative '../lib/item'

class ItemTest < Minitest::Test

  attr_reader :i

  def setup
    @i = Item.new({
      :id          => "263410303",
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99, 4),
      :merchant_id => "12334261",
      :created_at  => "2016-04-19 09:04:25 -0600",
      :updated_at  => "2016-04-19 09:04:25 -0600"
    })
  end

  def test_it_can_return_a_name
    assert_equal "Pencil", i.name
  end

  def test_it_can_return_a_description
    assert_equal "You can use it to write things", i.description
  end

  def test_it_can_return_a_unit_price
    assert_equal 10.99, i.unit_price_to_dollars
  end

  def test_it_can_return_when_it_was_created
    assert_equal "2016-04-19 09:04:25 -0600", i.created_at
  end

  def test_it_can_return_when_it_was_updated
    assert_equal "2016-04-19 09:04:25 -0600", i.updated_at
  end

  def test_it_can_return_an_item_id
    assert_equal 263410303, i.id
  end

  def test_it_can_return_merchant_id
    assert_equal 12334261, i.merchant_id
  end
end
