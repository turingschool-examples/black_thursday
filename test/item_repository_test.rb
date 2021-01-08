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

  def test_find_all_by_merchant_id
    assert_equal 6, @ir.find_all_by_merchant_id(12334185).count
  end

  def test_it_can_create_new_item
    attributes = ({
                :id          => 1,
                :name        => "Pencil",
                :description => "You can use it to write things",
                :unit_price  => 10.99,
                :created_at  => Time.now,
                :updated_at  => Time.now,
                :merchant_id => 2
                })

    @ir.create(attributes)

    assert_equal 263567475, attributes[:id]
  end

  def test_it_can_update_item
    attributes = {unit_price: 379.99,
                  name: "Oils",
                  description: "Smelly",
                  id: 23434353455654645}

    @ir.update(263397163, attributes)

    assert_equal 379.99, @ir.find_by_id(263397163).unit_price
    assert_equal "Oils", @ir.find_by_id(263397163).name
    assert_equal "Smelly", @ir.find_by_id(263397163).description
    assert_equal 263397163, @ir.find_by_id(263397163).id
  end

  def test_it_can_delete_item
    @ir.delete(263397163)

    assert_nil @ir.find_by_id(263397163)
  end
end
