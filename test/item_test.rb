require 'pry'
require_relative 'test_helper'
require_relative "../lib/item"
require "bigdecimal"

class ItemTest < Minitest::Test

  attr_reader :item

  def setup
    item_data = {:id          => "263519844",
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

  def test_it_has_attributes
    assert_equal "Pencil", @item.name
    assert_equal "You can use it to write things", @item.description
    assert_equal 0.1e2, @item.unit_price
    assert_equal Time.parse("2018-01-02 14:37:20 -0700"), @item.created_at
    assert_equal Time.parse("2018-01-02 14:37:25 -0700"), @item.updated_at
    assert_equal "$10.0", @item.unit_price_to_dollars
    assert_equal 263519844, @item.id
    assert_equal 12334105, @item.merchant_id
  end

  def test_returns_invoice_item_by_id
    item_id_1 = mock('263395237')
    item_id_2 = mock('263395237')
    item_id_3 = mock('263395237')

    item.item_repo.stubs(:find_invoice_items_by_id).returns([item_id_1, item_id_2, item_id_3])

    assert_equal 3, item.invoice_items.count
    assert_equal [item_id_1, item_id_2, item_id_3], item.invoice_items
  end

  def test_it_returns_unit_price_to_dollars
    price_1 = stub('10')

    item.item_repo.stubs(:find_invoice_items_by_id).returns([price_1])

    assert_equal '$10.0', item.unit_price_to_dollars
  end

  def test_item_returns_merchant
    merchant_1 = mock('263395237')
    merchant_2 = mock('263395237')
    merchant_3 = mock("263395237")
    item.item_repo.stubs(:find_merchant).returns([merchant_1, merchant_2, merchant_3])

    assert_equal 3, item.merchant.count
    assert_equal [merchant_1, merchant_2, merchant_3], item.merchant
  end

end
