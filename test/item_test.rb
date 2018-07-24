require_relative 'test_helper'
require_relative '../lib/item'

class ItemTest < MiniTest::Test
  def setup
    @item = Item.new({
                      :id          => 1,
                      :name        => "Pencil",
                      :description => "You can use it to write things",
                      :unit_price  => 60000,
                      :created_at  => "1972-07-30 18:08:53 UTC",
                      :updated_at  => "2016-01-11 18:30:35 UTC",
                      :merchant_id => 2
                    })
  end

  def test_it_exists
    assert_instance_of Item, @item
  end

  def test_it_has_a_name
    assert_equal "Pencil", @item.name
  end

  def test_it_has_a_description
    assert_equal "You can use it to write things", @item.description
  end

  def test_it_has_an_id_number
    assert_equal 1, @item.id
  end

  def test_it_has_a_unit_price
    assert_equal 600, @item.unit_price
  end

  def test_it_has_a_created_time
    assert_equal "1972-07-30 18:08:53 UTC", @item.created_at
  end

  def test_it_has_a_updated_time
    assert_equal "2016-01-11 18:30:35 UTC", @item.updated_at
  end

  def test_it_has_a_merchant_id
    assert_equal 2, @item.merchant_id
  end

end
