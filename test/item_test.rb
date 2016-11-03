require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/item_repository'

class ItemTest < Minitest::Test
  attr_reader   :item,
                :item_2,
                :ir

  def setup
    @ir = ItemRepository.new('./fixture/items.csv')
    @item = Item.new({
      :id => 1,
      :name => "Pencil",
      :description => "You can use it to write things",
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => "2015-01-01 11:11:37 UTC",
      :updated_at => "2015-10-10 11:11:37 UTC",
      :merchant_id => 100,
      :parent => @ir
    }, ir)
    @item_2 = Item.new({
      :id => 2,
      :name => "Pen",
      :description => "You can use it to write things",
      :unit_price => 10,
      :created_at => "2015-01-01 11:11:37 UTC",
      :updated_at => "2015-10-10 11:11:37 UTC",
      :merchant_id => 101,
      :parent => @ir
    }, ir)
  end

  def test_it_can_create_an_item
    assert item
  end

  def test_it_can_return_id
    assert_equal 1, item.id
    assert_equal 2, item_2.id
  end

  def test_it_can_return_name
    assert_equal "Pencil", item.name
    assert_equal "Pen", item_2.name
  end

  def test_it_can_return_unit_price_as_big_decimal
    assert_equal 10.99, item.unit_price
    assert_instance_of BigDecimal, item.unit_price
    assert_equal 10.00, item_2.unit_price
    assert_instance_of BigDecimal, item_2.unit_price
  end

  def test_it_can_return_created_at_as_time
    ##Need to find a way to test this properly
    assert_instance_of Time, item.created_at
    assert_instance_of Time, item_2.created_at
  end

  def test_it_can_return_updated_at_as_time
    ##Need to find a way to test this properly
    assert_instance_of Time, item.updated_at
    assert_instance_of Time, item_2.updated_at
  end

  def test_it_can_return_merchant_id
    assert_equal 100, item.merchant_id
  end

  def test_it_can_return_price_in_dollars_as_float
    assert_instance_of Float, item.unit_price_to_dollars
    assert_instance_of Float, item_2.unit_price_to_dollars
  end

  def test_that_an_item_knows_who_its_parent_is
    assert_equal @ir, item.parent
  end
end
