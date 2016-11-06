require_relative 'test_helper'
require_relative '../lib/item'
require_relative '../lib/data_parser'

class ItemTest < Minitest::Test
    include DataParser
  def test_item_class_exists
    assert_instance_of Item, Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 12})
    end

    def test_it_can_access_merchant_item_attributes
      i = Item.new({
        :id          => "1",
        :name        => "Pencil",
        :description => "You can use it to write things",
        :unit_price  => "250000",
        :created_at  => Time.now,
        :updated_at  => Time.now,
        :merchant_id => "12"
        })
        assert_equal 1, i.id
        assert_equal "Pencil", i.name
        assert_equal "You can use it to write things", i.description
        assert_equal 2500.0, i.unit_price
        assert_respond_to i, :created_at
        assert_respond_to i, :updated_at
        assert_equal 12, i.merchant_id
    end

    def test_item_can_parse_rows
      file = './data/items.csv'
      assert_instance_of Array, parse_data(file)
    end
  end
