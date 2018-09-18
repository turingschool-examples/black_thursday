require_relative '../test/test_helper'
require_relative '../lib/item_repository'
require 'bigdecimal'

class ItemRepositoryTest < Minitest::Test

  def setup
    @ir = ItemRepository.new
    @hash = {
      :id          => "1",
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => "1099",
      :created_at  => "2016-01-11 09:34:06 UTC",
      :updated_at  => "2016-01-11 09:34:06 UTC",
      :merchant_id => "2"
    }
  end

  def test_it_exists
    @ir = ItemRepository.new
    assert_instance_of ItemRepository, @ir
  end

  def test_has_no_items_to_start
    @ir = ItemRepository.new
    assert_equal [], @ir.all
  end

  def test_new_item_added_to_item_array
    @ir.create(@hash)
    assert_instance_of Item, @ir.all[0]
  end

  def test_it_can_add_by_hash_attributes
    @ir.create(@hash)
    hash2 = {
      :name        => "Journal",
      :description => "You can write in",
      :unit_price  => "1099",
      :merchant_id => "2",
      :created_at  => "2016-01-11 09:34:06 UTC",
      :updated_at  => "2016-01-11 09:34:06 UTC"
    }
    @ir.create(hash2)
    assert_equal 2, @ir.all.length
  end

  def test_it_returns_nil_with_no_matching_id
    @ir.create(@hash)
    assert_nil @ir.find_by_id(1234)
  end

  def test_it_can_return_by_id
    @ir.create(@hash)
    assert_equal "Pencil", @ir.find_by_id(1).name
  end

  def test_it_returns_nil_with_no_matching_names
    @ir.create(@hash)
    assert_nil @ir.find_by_name("Water Buffalo")
  end

  def test_it_can_return_by_name
    @ir.create(@hash)
    assert_equal "Pencil", @ir.find_by_name("Pencil").name
  end

  def test_it_returns_an_empty_array_with_no_name_matches
    @ir.create(@hash)
    assert_nil @ir.find_by_name("Water Buffalo")
  end

  def test_it_can_find_next_by_id
    @ir.create(@hash)
    assert_equal 2, @ir.find_next_id
  end

  def test_it_can_return_by_price
    @ir.create(@hash)
    assert_equal "Pencil", @ir.find_all_by_price(10.99)[0].name
  end

  def test_it_returns_empty_array_with_no_matchching_prices
    @ir.create(@hash)
    assert_equal [], @ir.find_all_by_price(11.99)
  end

  def test_it_can_return_by_price_range
    @ir.create(@hash)
    hash2 = {
      :id          => "2",
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => "1199",
      :created_at  => "2007-06-04 21:35:10 UTC",
      :updated_at  => "2016-01-11 09:34:06 UTC",
      :merchant_id => "2"
    }
    @ir.create(hash2)
    assert_equal 2, @ir.find_all_by_price_in_range(10..12).length
  end

  def test_it_returns_empty_array_with_no_matchching_price_range
    @ir.create(@hash)
    assert_equal [], @ir.find_all_by_price_in_range(1..5)
  end

  def test_it_can_return_all_by_merchant_id
    @ir.create(@hash)
    hash2 = {
      :id          => "2",
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => "1199",
      :created_at  => "2007-06-04 21:35:10 UTC",
      :updated_at  => "2016-01-11 09:34:06 UTC",
      :merchant_id => "2"
    }
    @ir.create(hash2)
    hash3 = {
      :id          => "2",
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => "1199",
      :created_at  => "2007-06-04 21:35:10 UTC",
      :updated_at  => "2016-01-11 09:34:06 UTC",
      :merchant_id => "3"
    }
    @ir.create(hash3)
    assert_equal 2, @ir.find_all_by_merchant_id(2)[0].merchant_id
    assert_equal 2, @ir.find_all_by_merchant_id(2).length

  end

  def test_it_returns_empty_array_with_no_matching_merchant_id
    @ir.create(@hash)
    assert_equal [], @ir.find_all_by_merchant_id(100)
  end

  def test_it_can_find_all_with_description
    @ir.create(@hash)
    hash2 = {
      :id          => "2",
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => "1199",
      :created_at  => "2007-06-04 21:35:10 UTC",
      :updated_at  => "2016-01-11 09:34:06 UTC",
      :merchant_id => "2"
    }
    @ir.create(hash2)
    hash3 = {
      :id          => "2",
      :name        => "Eraser",
      :description => "Erase things",
      :unit_price  => "1199",
      :created_at  => "2007-06-04 21:35:10 UTC",
      :updated_at  => "2016-01-11 09:34:06 UTC",
      :merchant_id => "3"
    }
    @ir.create(hash3)
    str = "You can use it to write things"
    assert_equal 2, @ir.find_all_with_description(str).length
  end

  def test_it_can_find_all_with_partial_description
    @ir.create(@hash)
    hash2 = {
      :id          => "2",
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => "1199",
      :created_at  => "2007-06-04 21:35:10 UTC",
      :updated_at  => "2016-01-11 09:34:06 UTC",
      :merchant_id => "2"
    }
    @ir.create(hash2)
    hash3 = {
      :id          => "2",
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => "1199",
      :created_at  => "2007-06-04 21:35:10 UTC",
      :updated_at  => "2016-01-11 09:34:06 UTC",
      :merchant_id => "3"
    }
    @ir.create(hash3)
    str = "You"
    assert_equal 3, @ir.find_all_with_description(str).length
  end

  def test_it_returns_empty_array_with_no_matching_description
    @ir.create(@hash)
    str = "Hello"
    assert_equal [], @ir.find_all_with_description(str)
  end

  def test_it_can_update_attributes
    @ir.create(@hash)
    update_attributes = {
      name: "Eraser",
      description: "It erases things",
      unit_price: BigDecimal.new(12.21, 4)
    }
    @ir.update(1,update_attributes)
    assert_equal "Eraser", @ir.all[0].name
    assert_equal "It erases things", @ir.all[0].description
    assert_equal 12.21, @ir.all[0].unit_price_to_dollars
    assert_equal Time.now.min, @ir.all[0].updated_at.min
  end

  def test_it_can_delete
    @ir.create(@hash)
    hash2 = {
      :id          => "2",
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => "1199",
      :created_at  => "2007-06-04 21:35:10 UTC",
      :updated_at  => "2016-01-11 09:34:06 UTC",
      :merchant_id => "2"
    }
    @ir.create(hash2)
    @ir.delete(2)
    assert_equal 1, @ir.all.length

  end
end
