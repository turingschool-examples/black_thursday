gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/item'
require_relative '../lib/sales_engine'

class ItemClassTest < Minitest::Test

  def setup
    @item = Item.new(SalesEngine.new,{:id => 2342,
                     :name => "MY Item",
                     :description => "Best item ever",
                     :unit_price => 1500,
                     :merchant_id => 23,
                     :created_at => "2009-02-07",
                     :updated_at => "2009-02-07"})
  end

  def test_can_initialize_an_item_and_it_exists
    assert Item.new(SalesEngine.new,{})
  end

  def test_can_send_in_item_information_and_it_is_a_part_of_the_item_and_can_be_inspected
    #Using the item created in setup
    expected = "  id: 2342
    name: MY Item
    description: Best item ever
    unit price: 0.15E2
    merchant id: 23
    created at: 2009-02-07
    updated at: 2009-02-07"
    assert_equal expected, @item.inspect
  end

  def test_can_get_item_name
    assert_equal "MY Item", @item.name
  end

  def test_can_get_item_id
    assert_equal 2342, @item.id
  end

  def test_can_get_description
    assert_equal "Best item ever", @item.description
  end

  def test_can_get_unit_price
    assert_equal 0.15E2, @item.unit_price
  end

  def test_can_get_unit_price_in_dollars
    assert_equal "$15.00", @item.unit_price_to_dollars
  end

  def test_can_get_merchant_id
    assert_equal 23, @item.merchant_id
  end

  def test_can_get_time_created_and_time_updated
    assert_equal Time.new(2009, 02, 07).to_s, @item.created_at.to_s
    assert_equal Time.new(2009, 02, 07).to_s, @item.updated_at.to_s
  end



end
