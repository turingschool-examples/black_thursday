require_relative 'test_helper'
require_relative '../lib/item'

class ItemTest < MiniTest::Test
  attr_reader :item

  def setup
    @item = Item.new({:id => 1,
                      :name => "Turing School",
                      :description => "teach me to code",
                      :unit_price => 100,
                      :created_at => "18",
                      :updated_at => "19",
                      :merchant_id => 999})
  end

  def test_it_exists
    assert_instance_of Item, item
  end

  def test_it_can_access_attributes
    assert_equal 1, item.id
    assert_equal "Turing School", item.name
    assert_equal "teach me to code", item.description
    assert_equal 1.00, item.unit_price
    assert_equal "2017-11-18 00:00:00 -0700", item.created_at.to_s
    assert_equal "2017-11-19 00:00:00 -0700", item.updated_at.to_s
    assert_equal 999, item.merchant_id
  end

  def test_can_convert_integer_into_dollar
    assert_equal 1.00, item.unit_price#_to_dollars
  end
end
