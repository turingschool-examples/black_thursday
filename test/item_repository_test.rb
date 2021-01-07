require_relative './test_helper'
require './lib/item'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def setup
    @ir = ItemRepository.new("./data/items.csv", "engine")
  end

  def test_it_exists_and_has_attributes
    assert_instance_of ItemRepository, @ir
  end

  def test_it_can_create_items_from_csv
    assert_equal 1367, @ir.all.count
  end

  def test_it_finds_by_id
    item = @ir.all.first

    assert_equal item, @ir.find_by_id(263395237)
  end

  def test_find_by_name
    item = @ir.all.first

    assert_equal item, @ir.find_by_name("510+ RealPush Icon Set")
  end

  def test_find_all_with_description
    assert_equal false, @ir.find_all_with_description("to go transparent PNG in 8 size").empty?
    assert_equal true, @ir.find_all_with_description("kvjbdfskvjbdkflbvkdfbvdlkb").empty?
  end

  def test_find_all_by_price
    item = @ir.all.first

    assert_equal 41, @ir.find_all_by_price(1200.0).count
  end

  def test_find_all_by_price_in_range
    assert_equal 205, @ir.find_all_by_price_in_range(1000.0..1500.0).count
  end

end
