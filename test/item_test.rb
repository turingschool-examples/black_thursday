require_relative '../lib/item'
require_relative './test_helper'


class ItemTest < Minitest::Test
  def test_it_exists
    i = Item.new({
    :id          => 1,
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => 200,
    :created_at  => "2016-01-11 09:34:06 UTC",
    :updated_at  => "2007-06-04 21:35:10 UTC",
    :merchant_id => 2
    })

    assert_instance_of Item, i
  end

  def test_it_has_attributes
    i = Item.new({
    :id          => 1,
    :name        => "Pencil",
    :description => "You can use it to write things",
    :unit_price  => 200,
    :created_at  => "2016-01-11 09:34:06 UTC",
    :updated_at  => "2007-06-04 21:35:10 UTC",
    :merchant_id => 2
    })

    assert_equal 1, i.id
    assert_equal "Pencil", i.name
    assert_equal "You can use it to write things", i.description
    assert_equal 2, i.unit_price
    assert_equal "2016-01-11 09:34:06 UTC", i.created_at
    assert_equal "2007-06-04 21:35:10 UTC", i.updated_at
    assert_equal 2, i.merchant_id
    assert_equal 2.00, i.unit_price_to_dollars
  end




end
