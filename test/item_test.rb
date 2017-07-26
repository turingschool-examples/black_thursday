require './lib/sales_engine'
require 'bigdecimal'
require 'time'
require './lib/item'
require 'csv'
require 'minitest/autorun'
require 'minitest/emoji'

class ItemTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })

    @item = Item.new({
                      :name        => "Pencil",
                      :description => "You can use it to write things",
                      :unit_price  => BigDecimal.new(10.99,4),
                      :created_at  => Time.now,
                      :updated_at  => Time.now,
                      }, @se.item)



  end

  def test_it_exists
    assert_instance_of Item, @item
  end

  def test_it_has_an_id
    assert_equal "Pencil", @item.name
  end

  def test_it_has_a_description_unit_price_created_at_updated_at
    assert_equal "You can use it to write things", @item.description
    assert_instance_of BigDecimal, @item.unit_price
    assert_instance_of Time, @item.created_at
    assert_instance_of Time, @item.updated_at
  end

  def test_unit_price_to_dollars
    assert_equal 0.11, @item.unit_price_to_dollars.to_f.round(2)
  end

  def test_merchant_returns_the_merchant_of_the_item
    item_instance = @se.item.find_by_id(263395237)
    assert_instance_of Merchant, item_instance.merchant
  end


end
