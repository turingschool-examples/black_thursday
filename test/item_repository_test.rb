require_relative './test_helper'
require 'bigdecimal'
require 'time'
require './lib/item'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def setup
    @ir = ItemRepository.new("./fixture_data/items_fixtures_file.csv", "engine")
  end

  def test_it_exists_and_has_attributes
    assert_instance_of ItemRepository, @ir
  end

  def test_it_can_create_items_from_csv
    assert_equal 29, @ir.all.count
  end

  def test_it_finds_by_id
    item = @ir.all.first

    assert_equal item, @ir.find_by_id(263395237)
    assert_nil @ir.find_by_id(2631215446511)
  end

  def test_find_by_name
    item = @ir.all.first

    assert_equal item, @ir.find_by_name("510+ RealPush Icon Set")
    assert_nil @ir.find_by_name("I'm hungry")
  end

  def test_find_all_with_description
    assert_equal false, @ir.find_all_with_description("to go transparent PNG in 8 size").empty?
    assert_equal true, @ir.find_all_with_description("kvjbdfskvjbdkflbvkdfbvdlkb").empty?
    assert_equal [], @ir.find_all_with_description("kvjbdfskvjbdkflbvkdfbvdlkb")
  end

  def test_find_all_by_price
    item = @ir.all.first

    assert_equal 1, @ir.find_all_by_price(20.0).count
    assert_equal 0, @ir.find_all_by_price(200000.0).count
  end

  def test_find_all_by_price_in_range
    assert_equal 10, @ir.find_all_by_price_in_range(10.0..30.0).count
    assert_equal [], @ir.find_all_by_price_in_range(10000.0..300000.0)
  end

  def test_find_all_by_merchant_id
    assert_equal 3, @ir.find_all_by_merchant_id(12334185).count
    assert_equal [], @ir.find_all_by_merchant_id(1234105848451)
  end

  def test_it_can_create_new_item
    expected = @ir.new_highest_id
    attributes = ({
                :id          => 1,
                :name        => "Pencil",
                :description => "You can use it to write things",
                :unit_price  => "1099",
                :created_at  => Time.now,
                :updated_at  => Time.now,
                :merchant_id => 2
                })

    @ir.create(attributes)

    assert_equal expected, attributes[:id]
  end

  def test_it_can_update_item
    attributes = {unit_price: "37999",
                  name: "Oils",
                  description: "Smelly",
                  id: 23434353455654645}

    @ir.update(263397163, attributes)
    item_test_updated_at = @ir.find_by_id(263397163).updated_at.strftime("%d/%m/%Y")

    assert_equal BigDecimal.new("37999".to_i)/100, @ir.find_by_id(263397163).unit_price
    assert_equal "Oils", @ir.find_by_id(263397163).name
    assert_equal "Smelly", @ir.find_by_id(263397163).description
    assert_equal 263397163, @ir.find_by_id(263397163).id
    assert_equal Time.now.strftime("%d/%m/%Y"), item_test_updated_at
  end

  def test_it_can_delete_item
    @ir.delete(263397163)

    assert_nil @ir.find_by_id(263397163)
  end

  def test_new_highest_id
    assert_equal 263399476, @ir.new_highest_id
  end
end
