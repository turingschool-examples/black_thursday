require 'bigdecimal'

require './test/test_helper'

require './lib/item'


class ItemTest < Minitest::Test

  attr_reader :time, :item
  def setup
    @time = Time.now
    @item = Item.new({
      :id          => "1",
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => time,
      :updated_at  => time,
      :merchant_id => "33"
    })
  end

  def test_instance_of_Item_exists
    assert_instance_of Item, item
  end

  def test_id_returns_the_integer_id_of_the_item
    assert_equal "1" , item.id
  end

  def test_id_returns_the_integer_id_of_the_item
    assert_equal "1" , item.id
  end

  def test_name_returns_the_name_of_the_item
    assert_equal "Pencil" , item.name
  end

  def test_decription_returns_the_description_of_the_item
    assert_equal "You can use it to write things" , item.description
  end

  def test_unit_price_returns_the_price_of_the_item
    assert_equal BigDecimal.new(10.99,4), item.unit_price
  end

  def test_created_at_returns_a_Time_instance_for_the_date
    assert_equal time, item.created_at
  end

  def test_updated_at_returns_a_Time_instance_for_the_date_last_modified
    assert_equal time, item.updated_at
  end

  def test_merchant_id_returns_the_integer_merchant
    assert_equal "33", item.merchant_id
  end

end
