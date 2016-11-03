require_relative 'test_helper'
require_relative '../lib/item'
require 'bigdecimal'
require 'time'

class ItemTest < Minitest::Test

  def setup
    item_info_1 = ({
      :id          => "5",
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => "2500",
      :created_at  => "2016-11-01 11:38:28 -0600",
      :updated_at  => "2016-11-01 14:38:28 -0600",
      :merchant_id => "10"
    })
    item_info_2 = ({
      :id          => nil,
      :name        => nil,
      :description => nil,
      :unit_price  => nil,
      :created_at  => "2016-11-01 11:38:28 -0600",
      :updated_at  => "2016-11-01 14:38:28 -0600",
      :merchant_id => nil
    })
    parent = Minitest::Mock.new
    @item1 = Item.new(item_info_1, parent)
    @item2 = Item.new(item_info_2, parent)
    @item3 = Item.new()
    @item4 = Item.new({})
  end

  def test_it_exists
    assert @item1
  end

  def test_merchant_calls_parent
    @item1.parent.expect(:find_item_merchant_by_merch_id, nil, [10])
    @item1.merchant
    @item1.parent.verify
  end

  def test_it_initializes_item_id
    assert_equal 5, @item1.id
  end

  def test_it_initializes_item_name
    assert_equal "Pencil", @item1.name
  end

  def test_it_initializes_item_description
    expected = "You can use it to write things"
    assert_equal expected, @item1.description
  end

  def test_it_initializes_item_unit_price
    expected = BigDecimal.new(25.00,4)
    assert_equal expected, @item1.unit_price
  end

  def test_it_initializes_item_create_time
    expected = Time.parse("2016-11-01 11:38:28 -0600")
    assert_equal expected, @item1.created_at
  end

  def test_it_initializes_item_update_time
    expected = Time.parse("2016-11-01 14:38:28 -0600")
    assert_equal expected, @item1.updated_at
  end

  def test_it_initializes_item_merchant_id
    assert_equal 10, @item1.merchant_id
  end

  def test_it_returns_unit_price_in_dollars
    assert_equal 25.01, @item1.unit_price_to_dollars("2501")
  end

  def test_it_returns_zero_if_there_is_no_id_given
    assert_equal 0, @item2.id
  end

  def test_it_returns_empty_string_if_there_is_no_name_given
    assert_equal "", @item2.name
  end

  def test_it_returns_empty_string_if_there_is_no_description_given
    assert_equal "", @item2.description
  end

  def test_it_returns_zero_if_there_is_no_unit_price_given
    assert_equal 0, @item2.unit_price
  end

  def test_it_returns_zero_if_there_is_no_id_given
    assert_equal 0, @item2.id
  end

  def test_it_returns_zero_if_there_is_no_merchant_id_given
    assert_equal 0, @item2.merchant_id
  end

  def test_it_returns_blank_item_object_if_no_data_passed
    assert_equal Item, @item3.class
    assert_nil @item3.id
    assert_nil @item3.created_at
    assert_nil @item3.description
  end

  def test_it_returns_blank_item_object_if_empty_hash_passed
    assert_equal Item, @item4.class
    assert_nil @item4.name
    assert_nil @item4.unit_price
    assert_nil @item4.merchant_id
  end

end