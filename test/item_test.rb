require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/item'
require './lib/cleaner'
# refactor to mock/stubs or traverse vertically to not need to require IR?
# But in the update test we do need to check on a real item i think
require './lib/item_repo'

class ItemTest < Minitest::Test
  def setup
    @item = Item.new({
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99, 4),
      :created_at  => 10,
      :updated_at  => 12,
      :merchant_id => 2
      })
      @cleaner = Cleaner.new # refactor out?
  end

  def test_it_exists_with_attributes
    assert_instance_of Item, @item
    assert_equal 1, @item.id
    assert_equal "Pencil", @item.name
    assert_equal "You can use it to write things", @item.description
    assert_equal 0.1099e2, @item.unit_price
    assert_equal 10, @item.created_at
    assert_equal 12, @item.updated_at
    assert_equal 2, @item.merchant_id
  end

  def test_unit_price_to_dollars
    assert_equal 0.11, @item.unit_price_to_dollars
  end

  def test_it_updates_item_attributes
    ir = ItemRepository.new

    attributes = {
      name: "Capita Defenders of Awesome 2018",
      description: "This board both rips and shreds",
      unit_price: BigDecimal.new(399.99, 5),
      created_at: Time.now,
      updated_at: Time.now,
      merchant_id: 25
    }

    Time.stubs(:now).returns("Black Thursday")

    updated_attribute_hash = {
      :id          => 888444555,
      :name        => "Bleeps",
      :description => "doop doop doop",
      :unit_price  => BigDecimal.new(599.99, 5),
      :created_at  => Time.now,
      :merchant_id => 46
    }

    ir.create(attributes)
    target_item = ir.find_item_by_id(263567475)[0]
    target_item.update(updated_attribute_hash)
    # check attributes were updated
    assert_equal "Bleeps", target_item.name
    assert_equal "doop doop doop", target_item.description
    assert_equal BigDecimal.new(599.99, 5), target_item.unit_price
    # check permanent attributes are unchanged
    assert_equal 263567475, target_item.id
    assert_equal false, "Black Thursday" == target_item.created_at
    assert_equal false, 46 == target_item.merchant_id
  end
end
