require_relative './test_helper'

class ItemRepositoryTest < Minitest::Test

  def setup
    @time = Time.now.to_s
    @item_1 = Item.new({
              :id          => 1,
              :name        => "Pencil",
              :description => "You can use it to write things in graphite",
              :unit_price  => BigDecimal.new(1099,4),
              :created_at  => @time,
              :updated_at  => @time,
              :merchant_id => 2
            })

    @item_2 = Item.new({
              :id          => 2,
              :name        => "Pen",
              :description => "You can use it to write things in ink!",
              :unit_price  => BigDecimal.new(3299,4),
              :created_at  => @time, #Time.now,
              :updated_at  => @time, #Time.now,
              :merchant_id => 3
            })
    @items = [@item_1, @item_2]
    # @ir = ItemRepository.new("./data/item_test.csv")
    @ir = ItemRepository.new(@items)
  end

  def test_it_exists

    assert_instance_of ItemRepository, @ir
  end

  def test_it_can_return_all_items
    assert_equal 2, @ir.all.size
    assert_equal 1, @ir.all[0].id
    assert_equal 2, @ir.all[1].id
  end

  def test_it_can_find_by_id
    assert_equal @ir.all[0], @ir.find_by_id(1)
    assert_nil @ir.find_by_id(26339620948425435436)
  end

  def test_it_can_find_by_name
    assert_equal @ir.all[0], @ir.find_by_name("Pencil")
    assert_equal @ir.all[1], @ir.find_by_name("PeN")
    assert_nil  @ir.find_by_name("steve")
  end

  def test_it_can_find_all_with_a_description
    assert_equal [], @ir.find_all_with_description("find me")
    assert_equal [@ir.all[0], @ir.all[1]], @ir.find_all_with_description("write things")
    assert_equal [@ir.all[0]], @ir.find_all_with_description("You cAn use iT to WRite things in GraPHiTe")
  end
#
  def test_can_find_all_items_with_same_price
    assert_equal [], @ir.find_all_by_price(50)
    # binding.pry
    assert_equal [@ir.all[0]], @ir.find_all_by_price(10.99)

  end
#
  def test_it_can_find_items_within_range_of_price
    assert_equal [], @ir.find_all_by_price_in_range((100..102))
    assert_equal [@ir.all[0], @ir.all[1]], @ir.find_all_by_price_in_range((0..59))
    assert_equal [@ir.all[0]], @ir.find_all_by_price_in_range((0..15.00))
  end
#
  def test_it_can_find_all_items_with_merchant_id

    assert_equal [], @ir.find_all_by_merchant_id(100)
    assert_equal [@ir.all[0]], @ir.find_all_by_merchant_id(2)
  end
#
  def test_it_can_create_a_new_item
    new_item = @ir.create({
              :name        => "fountain pen",
              :description => "You can use it to write things fancily",
              :unit_price  => BigDecimal.new(10.99,4),
              :created_at  => " ",
              :updated_at  => "1993-09-29 11:56:40 UTC",
              :merchant_id => 2
            })
    assert_equal 3, new_item.id
    assert_equal "fountain pen", new_item.name
  end
#
  def test_it_can_update_items
    price = BigDecimal.new(9.99,4)
    @ir.update(2, {
              :name        => "mechanical pencil",
              :description => "You can use it to write things thinly",
              :unit_price  => price
              })
    assert_equal 2, @ir.all[1].id
    assert_equal "mechanical pencil", @ir.all[1].name
    assert_equal price, @ir.all[1].unit_price
    assert_equal "You can use it to write things thinly", @ir.all[1].description
  end
#
  def test_it_can_delete_item
    item = @ir.all[1]
    @ir.delete(2)
    refute @ir.all.include?(item)
  end

  def test_it_can_return_inpect_data
    assert_equal "#<ItemRepository 2 rows>", @ir.inspect
  end

end
