require_relative 'test_helper'
require_relative "../lib/item"
require "bigdecimal"

class ItemTest < Minitest::Test

  attr_reader :item

  def setup
    item_data = {
      :id          => "263519844",
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(1000.99,1),
      :created_at  => "2018-01-02 14:37:20 -0700",
      :updated_at  => "2018-01-02 14:37:25 -0700",
      :merchant_id => "12334105"}
    parent = mock('repository')
    @item = Item.new(item_data, parent)
  end

  def test_it_exists
    assert_instance_of Item, @item
  end

  def test_it_has_name
    assert_equal "Pencil", @item.name
  end

  def test_it_has_a_description
    assert_equal "You can use it to write things", @item.description
  end

  def test_it_has_unit_price
    assert_equal 0.1e2, @item.unit_price
  end

  def test_it_creates_at_a_time
    assert_equal Time.parse("2018-01-02 14:37:20 -0700"), @item.created_at
  end

  def test_it_returns_time_updated_at
    assert_equal Time.parse("2018-01-02 14:37:25 -0700"), @item.updated_at
  end

  def test_it_returns_unit_price_to_dollars
    assert_equal "$10.0", @item.unit_price_to_dollars
  end

  def test_has_item_id
    assert_equal 263519844, @item.id
  end

  def test_has_merchant_id
    assert_equal 12334105, @item.merchant_id
  end

  def test_it_returns_merchant_by_id
    se = SalesEngine.from_csv({
      merchants: "./test/fixtures/merchants_sample.csv",
      items: "./test/fixtures/items_sample.csv",
    })
    item = se.items.find_by_id(263395237)

    assert_equal "jejum", item.merchant.name
  end

end
