require './lib/item'
require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require 'bigdecimal'

class ItemTest < Minitest::Test

  def setup
    @item = Item.new({
                    :id          => 1,
                    :name        => "Pencil",
                    :description => "You can use it to write things",
                    :unit_price  => 50000,
                    :merchant_id => 66696969,
                    :created_at  => "2016-01-11 11:44:00 UTC",
                    :updated_at  => "2006-08-26 06:56:21 UTC"
                  })
  end

  def test_it_exists
    assert_instance_of Item, @item
  end

  def test_it_has_an_id
    assert_equal 1, @item.id
  end

  def test_it_has_a_name
    assert_equal "Pencil", @item.name
  end

  def test_it_has_a_description
    assert_equal "You can use it to write things", @item.description
  end

  def test_it_has_a_unit_price
    assert_equal 50000, @item.unit_price
  end

  def test_it_has_a_merchant_id
    assert_equal 66696969, @item.merchant_id
  end

  def test_it_has_a_created_at_date
    assert_equal "2016-01-11 11:44:00 UTC", @item.created_at
  end

  def test_it_has_an_updated_date
    assert_equal "2006-08-26 06:56:21 UTC", @item.updated_at
  end

  def test_it_can_convert_unit_price_to_dollars
    assert_equal 500.00, @item.unit_price_to_dollars
  end

  def test_it_can_find_merchant_by_item_id
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })

    item = se.items.find_by_id(263395237)

    assert_instance_of Merchant, item.merchant
  end

end
