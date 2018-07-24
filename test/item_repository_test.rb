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
    assert_equal [], @item_repository.find_all_by_price(BigDecimal.new(25.99,4))
    assert_equal [@item_1], @item_repository.find_all_by_price(BigDecimal.new(10.99,4))
  end

  def test_finds_all_by_price_range
    assert_equal [], @item_repository.find_all_by_price_in_range(25..79)
    assert_equal [@item_1, @item_2], @item_repository.find_all_by_price_in_range(10..13)
  end

  def test_finds_all_items_by_merchant_id
    assert_equal [], @item_repository.find_all_by_merchant_id(5)
    assert_equal [@item_3], @item_repository.find_all_by_merchant_id(12337777)
  end

  def test_can_create_new_item
    @item_repository.create({
          :id          => 837359,
          :name        => "Tacos",
          :description => "The most delicious food",
          :unit_price  => BigDecimal.new(1.99,4),
          :merchant_id => 123123123,
          :created_at  => Time.now,
          :updated_at  => Time.now
      })

    assert_equal 4, @item_repository.all.count
    assert_equal 263395986, @item_repository.all.last.id
  end

  def test_new_item_has_highest_id
    @item_repository.create({
          :id          => 837359,
          :name        => "Tacos",
          :description => "The most delicious food",
          :unit_price  => BigDecimal.new(1.99,4),
          :merchant_id => 123123123,
          :created_at  => Time.now,
          :updated_at  => Time.now
      })

    expected = @item_repository.all.max_by do |item|
                  item.id
                end

    assert_equal expected, @item_repository.all.last
  end

  def test_item_can_be_updated
    @item_repository.update(263395237, {
          :id          => 9,
          :description => "You can use it to write super cool things",
          :unit_price  => BigDecimal.new(15.99,4),
          :merchant_id => 12334141,
          :created_at  => Time.now,
          :updated_at  => Time.now
      })

    assert_equal "Pencil", @item_1.name
    assert_equal "You can use it to write super cool things", @item_1.description
    assert_equal BigDecimal.new(15.99,4), @item_1.unit_price
  end

  def test_items_can_be_deleted_by_id
    @item_repository.create({
          :id          => 837359,
          :name        => "Tacos",
          :description => "The most delicious food",
          :unit_price  => BigDecimal.new(1.99,4),
          :merchant_id => 123123123,
          :created_at  => Time.now,
          :updated_at  => Time.now
      })
    assert_equal 4, @item_repository.all.count

    @item_repository.delete(263395986)
    assert_equal 3, @item_repository.all.count

    assert_equal nil, @item_repository.find_by_name("Tacos")
  end
end
