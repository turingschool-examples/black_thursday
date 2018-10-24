require './test/test_helper'

class ItemRepositoryTest < Minitest::Test

  def setup
    @item_1 = Item.new({
              :id          => 1,
              :name        => "Pencil",
              :description => "You can use it to write things",
              :unit_price  => BigDecimal.new(10.99,4),
              :created_at  => @time,
              :updated_at  => @time,
              :merchant_id => 2
            })

    @item_2 = Item.new({
              :id          => 2,
              :name        => "Pen",
              :description => "You can use it to write things in ink!",
              :unit_price  => BigDecimal.new(32.99,4),
              :created_at  => Time.now,
              :updated_at  => Time.now,
              :merchant_id => 3
            })
    @items = [@item_1, @item_2]
    @ir = ItemRepository.new(@items)
  end

  def test_it_exists
    assert_instance_of ItemRepository, @ir
  end

  def test_it_can_return_all_items
    assert_equal @items, @ir.all
  end

  def test_it_can_find_by_id
    assert_equal @item_1, @ir.find_by_id(1)
    assert_nil @ir.find_by_id(10)
  end

  def test_it_can_find_by_name
    assert_equal @item_2, @ir.find_by_name("PeN")
    assert_equal @item_2, @ir.find_by_name("pen")
    assert_nil  @ir.find_by_name("steve")
  end

  def test_it_can_find_all_with_a_description
    assert_equal [], @ir.find_all_with_description("find me")
    assert_equal [@item_2], @ir.find_all_with_description("ink")
    assert_equal [@item_1, @item_2], @ir.find_all_with_description("wrIte thIngS")
  end

  def test_can_find_all_items_with_same_price
    assert_equal [], @ir.find_all_by_price(50)
    assert_equal [@item_1], @ir.find_all_by_price(10.99)
  end

  def test_it_can_find_items_within_range_of_price
    assert_equal [], @ir.find_all_by_price_in_range((100..102))
    assert_equal [@item_1, @item_2], @ir.find_all_by_price_in_range((0..40))
    assert_equal [@item_1], @ir.find_all_by_price_in_range((0..13))
  end

  def test_it_can_find_all_items_with_merchant_id
    assert_equal [], @ir.find_all_by_merchant_id(100)
    assert_equal [@item_1], @ir.find_all_by_merchant_id(2)
  end

  def test_it_can_create_a_new_item
    new_item = @ir.create({
              :name        => "fountain pen",
              :description => "You can use it to write things fancily",
              :unit_price  => BigDecimal.new(10.99,4),
              :created_at  => @time,
              :updated_at  => @time,
              :merchant_id => 2
            })
    assert_equal 3, new_item.id
    assert_equal "fountain pen", new_item.name
  end

  def test_it_can_update_items
    price = BigDecimal.new(9.99,4)
    @ir.update(1, {
              :name        => "mechanical pencil",
              :description => "You can use it to write things thinly",
              :unit_price  => price
              })
    assert_equal 1, @item_1.id
    assert_equal "mechanical pencil", @item_1.name
    assert_equal price, @item_1.unit_price
    assert_equal "You can use it to write things thinly", @ir.description
  end

  def test_it_can_delete_item
    @ir.delete(1)
    assert_equal [@item_2], @ir.all
  end
end
