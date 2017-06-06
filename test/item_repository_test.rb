require_relative 'test_helper'
require_relative '../lib/item_repository'
require_relative '../lib/sales_engine'

class ItemRepositoryTest < Minitest::Test
  attr_reader :item

  def setup
    @item = ItemRepository.new({
                  :items     => "./test/data/items_truncated.csv",
                  :merchants => "./test/data/merchants_truncated.csv"
                }, self)
  end

  def test_item_repo_instantiates
    actual   = @item.class
    expected = ItemRepository

    assert_equal expected, actual
  end

  def test_item_repo_opens_csv_into_array
    actual   = @item.all_item_data.class
    expected = Array

    assert_equal expected, actual
  end

  def test_it_returns_item_instances
    actual   = @item.all[0].class
    expected = Item

    assert_equal expected, actual
  end

  def test_it_can_return_ids
    actual   = @item.find_by_id(263395237)
    expected = @item.all[0]

    assert_equal expected, actual
  end

  def test_it_can_return_names
    actual   = @item.find_by_name("510+ RealPush Icon Set")
    expected = @item.all[0]

    assert_equal expected, actual
  end

  def test_it_can_find_all_with_description
    result = @item.find_all_with_description("glitter")
    actual = result[0].description.include?("glitter")

    assert_equal true, actual
  end

  def test_it_can_find_all_by_price
    result = @item.find_all_by_price(0.12E2)
    actual = result.count

    assert_equal 2, actual

  end

  def test_it_can_find_all_by_price_in_range
    result = @item.find_all_by_price_in_range(0.12E2..0.44E2)
    actual = result.count

    assert_equal 15, actual
  end

  def test_it_can_find_all_by_merchant_id
    result = @item.find_all_by_merchant_id(12334195)
    actual = result.count
    assert_equal 12, actual
  end

  def test_merchant_method_returns_item_value
  se = SalesEngine.from_csv({
    :items     => "./test/data/items_truncated.csv",
    :merchants => "./test/data/merchants_truncated.csv"
    })
    item = se.items.find_by_id(263395237)

    actual = item.merchant.id
    expected = 12334141

    assert_equal expected, actual
  end
end
