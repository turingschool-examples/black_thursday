require_relative 'test_helper'
require_relative '../lib/item_repository'
require_relative '../lib/item'

class ItemRepositoryTest < Minitest::Test
  def setup
    @item_1 = Item.new({
          :id          => 263395237,
          :name        => "Pencil",
          :description => "You can use it to write things",
          :unit_price  => BigDecimal.new(10.99,4),
          :merchant_id => 12334141,
          :created_at  => Time.now,
          :updated_at  => Time.now
      })
    @item_2 = Item.new({
          :id          => 263395985,
          :name        => "Marker",
          :description => "You can use it to write more things",
          :unit_price  => BigDecimal.new(12.99,4),
          :merchant_id => 12339191,
          :created_at  => Time.now,
          :updated_at  => Time.now
      })
    @item_3 = Item.new({
          :id          => 263395234,
          :name        => "Chapstick",
          :description => "Moisturizes lips.",
          :unit_price  => BigDecimal.new(4.55,4),
          :merchant_id => 12337777,
          :created_at  => Time.now,
          :updated_at  => Time.now
      })
    @items = [@item_1, @item_2, @item_3]
    @item_repository = ItemRepository.new(@items)
  end

  def test_it_exists
    assert_instance_of ItemRepository, @item_repository
  end

  def test_it_returns_all_item_instances
    expected = @items
    actual = @item_repository.all

    assert_equal expected, actual
  end

  def test_it_finds_items_by_id
    assert_equal nil, @item_repository.find_by_id(65)
    assert_equal @item_3, @item_repository.find_by_id(263395234)
  end

  def test_it_finds_item_by_item_name
    assert_equal nil, @item_repository.find_by_name("Tacos")
    assert_equal @item_2, @item_repository.find_by_name("Marker")
  end

  def test_it_finds_items_by_description
    actual = @item_repository.find_all_with_description("Made from tortillas")
    assert_equal [], actual
    actual = @item_repository.find_all_with_description("use it to write")
    assert_equal [@item_1, @item_2], actual
  end

  def test_it_finds_items_by_price 
    assert_equal [], @item_repository.find_all_
  end
end
