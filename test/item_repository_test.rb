require './test/test_helper'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def setup
    @item_1 = Item.new({
          :id          => 263397059,
          :name        => "Pencil",
          :description => "You can use it to write things",
          :unit_price  => BigDecimal.new(10.99,4),
          :created_at  => "2016-01-11 12:29:33 UTC",
          :updated_at  => "1993-08-29 22:53:20 UTC",
          :merchant_id => 213567
        })
    @item_2 = Item.new({
          :id          => 2347892358,
          :name        => "Marker",
          :description => "You can use it to mark things",
          :unit_price  => BigDecimal.new(12.50,4),
          :created_at  => "2016-01-11 12:02:55 UTC",
          :updated_at  => "1973-05-29 23:44:48 UTC",
          :merchant_id => 983406
        })
    @item_3 = Item.new({
          :id          => 2413,
          :name        => "Jump rope",
          :description => "Jump it",
          :unit_price  => BigDecimal.new(24.50,4),
          :created_at  => "2016-01-11 12:02:55 UTC",
          :updated_at  => "1973-05-29 23:44:48 UTC",
          :merchant_id => 245
        })
    @item_4 = Item.new({
          :id          => 6432,
          :name        => "Elf costume",
          :description => "Be santa's little helper.",
          :unit_price  => BigDecimal.new(30.65,4),
          :created_at  => "2016-01-11 12:05:55 UTC",
          :updated_at  => "1973-05-29 23:44:48 UTC",
          :merchant_id => 24524
        })
    @ir = ItemRepository.new
    @ir.add_item(@item_1)
    @ir.add_item(@item_2)
  end

  def test_it_exists
    ir = ItemRepository.new
    assert_instance_of ItemRepository, ir
  end

  def test_it_can_add_items_to_repository
    expected = [@item_1, @item_2]
    assert_equal expected, @ir.all
  end

  def test_it_can_find_item_by_id
    assert_equal @item_2, @ir.find_by_id(2347892358)
    assert_nil @ir.find_by_id(2385)
  end

  def test_find_item_by_name
    assert_equal @item_2, @ir.find_by_name("Marker")
    assert_nil @ir.find_by_name("Elephant")
  end

  def test_it_can_create_new_item_from_attributes
    id = 2347892359
    name = "Mickey Mouse Watch"
    description = "The best."
    unit_price = "18.00"
    created_at = "2012-01-11 12:02:55 UTC"
    updated_at = "1973-05-29 23:44:48 UTC"
    merchant_id = 213567

    expected_item = Item.new({
          :id          => id,
          :name        => name,
          :description => description,
          :unit_price  => unit_price,
          :created_at  => created_at,
          :updated_at  => updated_at,
          :merchant_id => merchant_id,
        })
    attributes = {
          :name        => name,
          :description => description,
          :unit_price  => unit_price,
          :created_at  => created_at,
          :updated_at  => updated_at,
          :merchant_id => merchant_id,
        }
    new_ir = @ir.create(attributes)
    @ir.add_item(new_ir)

    assert_equal expected_item.id, @ir.all.last.id
    assert_equal expected_item.name, @ir.all.last.name
  end

  def test_it_can_delete_by_id
    @ir.delete(2347892358)
    assert_equal [@item_1], @ir.all
  end

  def test_it_can_find_all_within_a_price_range
    @ir.add_item(@item_3)
    @ir.add_item(@item_4)
    expected = [@item_2, @item_3]
    assert_equal expected, @ir.find_all_by_price_in_range((11..28))
    assert_equal [], @ir.find_all_by_price_in_range((1000..1004))
  end

  def test_it_can_find_all_by_merchant_id
    @ir.add_item(@item_3)
    @ir.add_item(@item_4)
    item_5 = Item.new({
          :id          => 236234,
          :name        => "Kitty Figurine",
          :description => "Don't meow at me!",
          :unit_price  => BigDecimal.new(12.55,4),
          :created_at  => "2016-01-11 12:02:55 UTC",
          :updated_at  => "1973-05-29 23:44:48 UTC",
          :merchant_id => 983406
        })
    @ir.add_item(item_5)
    expected = [@item_2, item_5]
    assert_equal expected, @ir.find_all_by_merchant_id(983406)
    assert_equal [], @ir.find_all_by_merchant_id(2463)
  end

  def test_it_can_update_attributes
    attributes = {name: "Computer", description: "Awesome",
                  unit_price: BigDecimal.new(1200,4)}
    @ir.update(2347892358, attributes)
    assert_equal "Computer", @ir.find_by_id(2347892358).name
    assert_equal "Awesome", @ir.find_by_id(2347892358).description
    assert_equal BigDecimal.new(1200,4), @ir.find_by_id(2347892358).unit_price
  end

  def test_find_item_by_description
    assert_equal @item_2, @ir.find_all_with_description("You can use it to mark things")
  end

  def test_find_all_by_price
    assert_equal [@item_2], @ir.find_all_by_price(BigDecimal.new(12.50,4))
    assert_equal [], @ir.find_all_by_price(BigDecimal.new(1289223.50,4))
  end

end
