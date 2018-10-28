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
      :merchant_id => 3
    }

    @item_4 = {
      :id          => 4,
      :name        => "Red Pajamas",
      :description => "You can use it to wear around the house",
      :unit_price  => BigDecimal.new(5.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 4
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

    expected = [Item.new(@item_1), Item.new(@item_2), Item.new(@item_3), Item.new(@item_4)]
    result = @ir.instances

    result.each_with_index {|item, index| assert item == expected[index]}
    assert_equal 4, @ir.instances.count
  end

  def test_it_can_create_items_without_passing_id
    assert_empty @ir.instances

    item_1_no_id = {
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }

    item_2_no_id = {
      :name        => "Penguin",
      :description => "You can use it to sled",
      :unit_price  => BigDecimal.new(9.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }

    @ir.create(item_1_no_id)
    @ir.create(item_2_no_id)

    expected = [Item.new(item_1_no_id), Item.new(item_2_no_id), Item.new(@item_3)]
    result = @ir.instances

    result.each_with_index do |item, index|
      assert item == expected[index]
      assert item.id == index + 1
    end
    assert_equal 2, @ir.instances.count
  end

  def test_find_all_with_description_returns_empty_array_if_none_found
    create_items

    assert_equal [],
    @ir.find_all_with_description("You can use it to eliminate rodents")
  end

  def test_find_all_with_description_returns_matching_merchants
    create_items

    expected = [Item.new(@item_3), Item.new(@item_4)]
    result = @ir.find_all_with_description("You can use it to wear around the house")

    result.each_with_index {|item, index| assert item == expected[index]}
  end

  def test_find_all_by_price_returns_empty_array_if_no_items_match
    create_items

    assert_equal [],
    @ir.find_all_by_price(10.88)
  end

  def test_find_all_by_price_returns_matching_items
    create_items

    result = [Item.new(@item_1), Item.new(@item_3)]
    expected = @ir.find_all_by_price(10.99)

    result.each_with_index {|item, index| assert item == expected[index]}
  end

  def test_find_all_by_price_range_returns_empty_array_if_no_items_match
    create_items

    assert_equal [],
    @ir.find_all_by_price_in_range(BigDecimal.new(12.99, 4)..BigDecimal.new(13.99, 4))
  end

  def test_find_all_by_price_range_returns_matches
    create_items

    expected = [Item.new(@item_2), Item.new(@item_4)]
    result = @ir.find_all_by_price_in_range(BigDecimal.new(5.99, 4)..BigDecimal.new(10, 2))

    result.each_with_index {|item, index| assert item == expected[index]}
  end

  def test_find_all_by_merchant_id_returns_empty_array_if_no_items_match
    create_items

    assert_equal [],
    @ir.find_all_by_merchant_id(5)
  end

  def test_find_all_by_merchant_id_returns_matches
    create_items

    expected = [Item.new(@item_1), Item.new(@item_2)]
    result = @ir.find_all_by_merchant_id(2)
    result.each_with_index {|item, index| assert item == expected[index]}
  end

  def test_update_returns_nil_if_no_item_with_id
    create_items

    assert_nil @ir.update(5, name: "Pen", description: "Writes things")
  end

  def test_update_succesfully_updates_item_with_new_attribute_values
    create_items

    item_previous = {
      :id          => 2,
      :name        => "Penguin",
      :description => "You can use it to sled",
      :unit_price  => BigDecimal.new(9.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }

    assert Item.new(item_previous) == @ir.find_by_id(2)

    item_updated = {
      :id          => 2,
      :name        => "Pen",
      :description => "Writes things",
      :unit_price  => BigDecimal.new(9.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }

    @ir.update(2, name: "Pen", description: "Writes things")

    assert Item.new(item_updated) == @ir.find_by_id(2)
  end

  def test_update_succesfully_updates_item_with_new_attribute_values_different_ones
    now = Time.now

    item_1 = {
      :id          => 1,
      :name        => "Penguin",
      :description => "You can use it to sled",
      :unit_price  => BigDecimal.new(8.99,4),
      :created_at  => now,
      :updated_at  => now,
      :merchant_id => 3
    }

    previous_item_2 = {
      :id          => 2,
      :name        => "Pajamas",
      :description => "You can use it to wear around the house",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => now,
      :updated_at  => now,
      :merchant_id => 3
    }

    @ir.create(item_1)
    @ir.create(previous_item_2)

    assert Item.new(previous_item_2) == @ir.find_by_id(2)

    @ir.update(2, unit_price: BigDecimal.new(9.99,4))

    updated_item_2 = {
      :id          => 2,
      :name        => "Pajamas",
      :description => "You can use it to wear around the house",
      :unit_price  => BigDecimal.new(9.99,4),
      :created_at  => now,
      :updated_at  => Time.now,
      :merchant_id => 3
    }

    assert Item.new(updated_item_2) == @ir.find_by_id(2)
  end

  def test_find_all_items_by_date
    #######
  end
end
