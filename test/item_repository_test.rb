require_relative '../test/test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def setup
    @ir = ItemRepository.new
    @hash = {
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }
  end

  def test_it_exists
    @ir = ItemRepository.new
    assert_instance_of ItemRepository, @ir
  end

  def test_has_no_items_to_start
    @ir = ItemRepository.new
    assert_equal [], @ir.items
  end

  def test_new_item_added_to_item_array
    @ir.create(@hash)
    assert_instance_of Item, @ir.items[0]
  end

  def test_it_can_add_by_string
    @ir.create(@hash)
    @ir.create("Pencil")
    assert_equal 2, @ir.all.length
  end

  def test_it_returns_nil_with_no_matching_id
    skip
    @ir.create(@hash)
    assert_nil @ir.find_by_name("Water Buffalo")
  end

  def test_it_can_return_by_id
    skip
    @ir.create(@hash)
    assert_equal "Pencil", @ir.find_by_id(1).name
  end

  def test_it_returns_nil_with_no_matching_names
    skip
    @ir.create(@hash)
    assert_nil @ir.find_by_name("Water Buffalo")
  end

  def test_it_can_return_by_name
    skip
    @ir.create(@hash)
    assert_equal "Pencil", @ir.find_by_name("Pencil").name
  end

  def test_it_returns_an_empty_array_with_no_name_matches
    skip
    @ir.create(@hash)
    assert_equal [], @ir.find_all_by_name("Water Buffalo")
  end

  def test_it_can_find_all_by_name_fragment
    skip
    @ir.create(@hash)
    assert_equal 1, @ir.find_all_by_name("pen").length
  end

  def test_it_can_find_next_by_id
    skip
    @ir.create(@hash)
    assert_equal 2, @ir.find_next_id
  end

  def test_it_can_return_by_price
    @ir.create(@hash)
    assert_equal "Pencil", @ir.return_all_by_price(10.99)[0].name
  end

  def test_it_returns_empty_array_with_no_matchching_prices
    @ir.create(@hash)
    assert_equal [], @ir.return_all_by_price(11.99)
  end

  def test_It_can_return_by_price_range
    @ir.create(@hash)
    hash2 = {
      :id          => 2,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(11.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }
    @ir.create(hash2)
    assert_equal 2, @ir.return_all_by_price_in_range(10..12).length
  end

  def test_it_can_return_all_by_merchant_id
    @ir.create(@hash)
    hash2 = {
      :id          => 2,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(11.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }
    @ir.create(hash2)
    hash3 = {
      :id          => 2,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(11.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 3
    }
    @ir.create(hash3)
    assert_equal 2, @ir.find_all_by_merchant_id(2)[0].id
    assert_equal 2, @ir.find_all_by_merchant_id.length

  end

  def test_it_returns_empty_array_with_no_matching_merchant_id
    @ir.create(@hash)
    assert_equal [], @ir.find_all_by_merchant_id(100)
  end

  def test_it_can_find_all_with_description
    @ir.create(@hash)
    hash2 = {
      :id          => 2,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(11.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }
    @ir.create(hash2)
    hash3 = {
      :id          => 2,
      :name        => "Pencil",
      :description => "You can use it to write",
      :unit_price  => BigDecimal.new(11.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 3
    }
    @ir.create(hash3)
    str = "You can use it to write things"
    assert_equal 2, @ir.find_all_with_description(str).length
  end

  def test_it_returns_empty_array_with_no_matching_description
    @ir.create(@hash)
    str = "Hello"
    assert_equal [], @ir.find_all_with_description(str)
  end
end
