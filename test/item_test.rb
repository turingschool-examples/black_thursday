gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require "minitest/nyan_cat"
require './lib/item'
require 'bigdecimal'

class ItemTest < Minitest::Test

  def setup
    @create_time = Time.new
    @update_time = Time.new
    item_info = ({
      :id          => 5,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => @create_time,
      :updated_at  => @update_time,
      :merchant_id => 10
    })
    @item = Item.new(item_info)  
  end

  def test_it_exists
    assert @item
  end

  def test_it_initializes_item_id
    assert_equal 5, @item.id
  end

  def test_it_initializes_item_name
    assert_equal "Pencil", @item.name
  end

  def test_it_initializes_item_description
    expected = "You can use it to write things"
    assert_equal expected, @item.description
  end

  def test_it_initializes_item_unit_price
    expected = BigDecimal.new(10.99,4)
    assert_equal expected, @item.unit_price
  end

  def test_it_initializes_item_create_time
    expected = @create_time
    assert_equal expected, @item.created_at
  end

  def test_it_initializes_item_update_time
    expected = @update_time
    assert_equal expected, @item.updated_at
  end

  def test_it_initializes_item_merchant_id
    assert_equal 10, @item.merchant_id
  end

  def test_it_returns_unit_price_in_dollars
    assert_equal 10.99, @item.unit_price_to_dollars
  end

  def test_it_checks_if_info_is_empty
    item_info = {}
    refute @item.item_info_clean?(item_info)
  end

  def test_it_checks_if_item_id_is_integer
    item_info = ({
      :id          => "0",
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => @create_time,
      :updated_at  => @update_time,
      :merchant_id => 10
    })
    refute @item.item_info_clean?(item_info)
  end

  def test_it_checks_if_item_name_is_string
    item_info = ({
      :id          => 5,
      :name        => :pencil,
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => @create_time,
      :updated_at  => @update_time,
      :merchant_id => 10
    })
    refute @item.item_info_clean?(item_info)
  end

  def test_it_checks_if_description_is_a_string
    item_info = ({
      :id          => 5,
      :name        => "Pencil",
      :description => nil,
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => @create_time,
      :updated_at  => @update_time,
      :merchant_id => 10
    })
    refute @item.item_info_clean?(item_info)
  end

  def test_it_checks_if_unit_price_is_a_big_decimal
    item_info = ({
      :id          => 5,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => 10,
      :created_at  => @create_time,
      :updated_at  => @update_time,
      :merchant_id => 10
    })
    refute @item.item_info_clean?(item_info)
  end

  def test_it_checks_if_create_time_is_a_time
    item_info = ({
      :id          => 5,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => "2016-10-31 15:21:13 -0600",
      :updated_at  => @update_time,
      :merchant_id => 10
    })
    refute @item.item_info_clean?(item_info)
  end

  def test_it_checks_if_update_time_is_a_time
    item_info = ({
      :id          => 5,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => @create_time,
      :updated_at  => "2016-10-31 15:21:13 -0600",
      :merchant_id => 10
    })
    refute @item.item_info_clean?(item_info)
  end
  
  def test_it_checks_if_merchant_id_is_an_integer
    item_info = ({
      :id          => 5,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => @create_time,
      :updated_at  => @update_time,
      :merchant_id => "turing"
    })
    refute @item.item_info_clean?(item_info)
  end

  def test_initialize_fails_if_info_not_clean
    item_info = ({
      :id          => "5",
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => 10.99,
      :created_at  => @create_time,
      :updated_at  => @update_time,
      :merchant_id => "10"
    })
    assert_raises(ArgumentError) {Item.new(item_info)}
  end

  def test_error_message_explains_problem
    string = "\n      Error:\n      :id and :merchant_id must be an Integer \n      :name and :description must be a String, \n      :unit_price must be a BigDecimal\n      :created_at and :updated_at must be a Time.\n      "  
    assert_equal string, @item.error
  end

end