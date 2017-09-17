require_relative 'test_helper'
require_relative '../lib/item'
require 'bigdecimal'
require 'time'

class ItemTest < Minitest::Test

  attr_reader :item

  def setup
    @item = Item.new({:id => 1,
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => "1099",
                    :created_at  => "2016-01-11 09:34:06 UTC",
                    :updated_at  => "2007-06-04 21:35:10 UTC",
                    :merchant_id => 666
                    })
  end

  def test_it_exists
    assert_instance_of Item, item
  end

  def test_parent_exist_and_defaults_to_nil
    actual = item.parent

    assert_nil actual
  end

  def test_it_has_an_id
    assert_equal 1, item.id
  end

  def test_it_has_a_name
    assert_equal "Pencil", item.name
  end

  def test_it_has_a_description
    assert_equal "You can use it to write things", item.description
  end

  def test_it_has_a_unit_price
    assert_instance_of BigDecimal, item.unit_price
  end

  def test_it_has_created_date
    assert_instance_of Time, item.created_at
  end

  def test_it_has_updated_date
    assert_instance_of Time, item.updated_at
  end

  def test_it_can_return_unit_price_to_dollars
    assert_equal 10.99, item.unit_price_to_dollars
  end

  def test_it_has_merchant_id
    assert_equal 666, item.merchant_id
  end

end
