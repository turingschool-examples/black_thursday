require './test/test_helper'

class ItemTest < Minitest::Test
  attr_reader :item
  def setup
    @item = Item.new({
      :id          => "2345",
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => "1099",
      :created_at  => "2017-02-24 09:33:28 -0700",
      :updated_at  => "2017-02-24 09:33:28 -0700",
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
    assert_equal BigDecimal.new(10.99, 4), item.unit_price
  end

  def test_created_time
    assert_equal Time.parse("2017-02-24 09:33:28 -0700"), item.created_at
  end

  def test_updated_time
    assert_equal Time.parse("2017-02-24 09:33:28 -0700"), item.updated_at
  end

  def test_item_merchant_id
    assert_equal 3333, item.merchant_id
  end

  def test_find_merchant_by_merchant_id
    se = SalesEngine.from_csv({items: './test/fixtures/items_match_merchant_id.csv', merchants: './test/fixtures/merchants_test_data.csv'})
    item = se.items.find_by_id(263501394)
    merchant = se.merchants.find_by_id(12334105)

    assert_equal merchant, item.merchant
  end
end
