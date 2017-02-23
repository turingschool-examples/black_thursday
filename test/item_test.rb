require './test/test_helper'

class ItemTest < Minitest::Test
  attr_reader :item
  def setup
    @item = Item.new({
      :id          => "2345",
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => "1099",
      :created_at  => Time.now.to_s,
      :updated_at  => Time.now.to_s,
      :merchant_id => '3333'})
  end

  def test_it_exists
    assert_kind_of Item, item
  end

  def test_it_has_an_id
    assert_equal 2345, item.id
  end

  def test_it_has_a_name
    assert_equal "Pencil", item.name
  end

  def test_item_has_description
    assert_equal "You can use it to write things", item.description
  end

  def test_item_has_unit_price
    assert_equal 10.99, item.unit_price
  end
end
