require_relative '../test/test_helper.rb'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def setup
    @item_repo = ItemRepository.new
    @item_1 = Item.new({
      :id          => "263395237",
      :name        => "Pencil",
      :description => "Best Pencil EVER!",
      :unit_price  => "1200",
      :updated_at  => Time.now,
      :created_at  => Time.now,
      :merchant_id => "14"
      })

    @item_2 = Item.new({
      :id          => "263395238",
      :name        => "Pen",
      :description => "Best Pen EVER!",
      :unit_price  => "1400",
      :updated_at  => Time.now,
      :created_at  => Time.now,
      :merchant_id => "14"
      })

    @item_3 = Item.new({
      :id          => "263395239",
      :name        => "Ruler",
      :description => "Best Ruler EVER!",
      :unit_price  => "800",
      :updated_at  => Time.now,
      :created_at  => Time.now,
      :merchant_id => "15"
      })

      @item_repo.items << @item_1
      @item_repo.items << @item_2
      @item_repo.items << @item_3

  end

  def test_it_exists
    assert_instance_of ItemRepository, @item_repo
  end

  def test_it_has_somewhere_to_store_items
    assert_instance_of Array, @item_repo.items
  end

  def test_it_can_return_all_items
    assert_equal @item_repo.items, @item_repo.all
  end

  def test_it_can_find_an_item_by_id
    assert_equal @item_repo.items[0], @item_repo.find_by_id(263395237)
  end

  def test_it_can_find_item_by_name_regardless_of_case
    assert_equal @item_repo.items[0], @item_repo.find_by_name("pencil")
  end

  def test_it_can_find_all_by_description
    assert_equal [@item_1, @item_2, @item_3], @item_repo.find_all_with_description("best")
    assert_equal [@item_3], @item_repo.find_all_with_description("ruler")

  end

  def test_it_can_find_all_by_price
    assert_equal 1, @item_repo.find_all_by_price(12.00).count
  end

  def test_it_can_find_all_by_price_in_range
    assert_equal 1, @item_repo.find_all_by_price_in_range(12.00..12.50).count
  end

  def test_it_can_find_all_by_merchant_id
    assert_equal [@item_3], @item_repo.find_all_by_merchant_id(15)
  end

  def test_it_can_create_a_new_item
    assert_equal 3, @item_repo.items.count
    @item_repo.create({
      :name        => "Mechanical Pencil",
      :description => "You can use it to write mechanical things.",
      :unit_price  => 1099,
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => "35"
    })
    assert_equal 4, @item_repo.items.count
  end

  def test_it_can_update_attributes
    @item_repo.update(263395237, {
                                  :name => "Sour Cream",
                                  :description => "Creamy, white, sour",
                                  :unit_price => "299"
                                })
    sour_creamy = @item_repo.find_by_id(263395237)
    assert_equal sour_creamy.name, "Sour Cream"
    assert_equal sour_creamy.description, "Creamy, white, sour"
    assert_equal sour_creamy.unit_price_to_dollars, 299.0
  end

  def test_it_can_delete_an_item
    assert_instance_of Item, @item_repo.find_by_id(263395237)
    @item_repo.delete(263395237)
    assert_nil @item_repo.find_by_id(263395237)
  end
end
