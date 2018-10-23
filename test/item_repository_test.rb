require './lib/item_repository'
require './lib/item'
require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'

class ItemRepositoryTest < Minitest::Test
  def setup
    @ir = ItemRepository.new

    @item_1 = {
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }

    @item_2 = {
      :id          => 2,
      :name        => "Penguin",
      :description => "You can use it to sled",
      :unit_price  => BigDecimal.new(9.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }

    @item_3 = {
      :id          => 3,
      :name        => "Pajamas",
      :description => "You can use it to wear around the house",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }

    @item_4 = {
      :id          => 4,
      :name        => "Red Pajamas",
      :description => "You can use it to wear around the house",
      :unit_price  => BigDecimal.new(5.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }
  end

  def create_items
    @ir.create(@item_1)
    @ir.create(@item_2)
    @ir.create(@item_3)
    @ir.create(@item_4)
  end

  def test_it_exists
    assert_instance_of ItemRepository, @ir
  end

  def test_it_creates_a_merchant_instance
    assert_empty @ir.instances

    create_items

    assert_equal 4, @ir.instances.count
    assert diff [Item.new(@item_1), Item.new(@item_2), Item.new(@item_3)], @ir.instances
  end

  def test_find_all_with_description_returns_empty_array_if_none_found
    create_items

    assert_equal ([]),
    @ir.find_all_with_description("You can use it to eliminate rodents")
  end

  def test_find_all_with_description_returns_matching_merchants
    create_items

    assert diff [Item.new(@item_3), Item.new(@item_4)],
    @ir.find_all_with_description("You can use it to wear around the house")
  end

  def test_find_all_by_price_returns_empty_array_if_no_items_match
    create_items

    assert_equal ([]),
    @ir.find_all_by_price(10.88)
  end

  def test_find_all_by_price_returns_matching_items
    create_items

    assert diff [Item.new(@item_1), Item.new(@item_3)],
    @ir.find_all_by_price(10.99)
  end

  def find_all_by_price_range_returns_empty_array_if_no_items_match
    skip
    create_items


  end
end
