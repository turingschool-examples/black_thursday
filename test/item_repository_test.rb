require_relative '../test/test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def test_it_exists
    ir = ItemRepository.new
    assert_instance_of ItemRepository, ir
  end

  def test_has_no_items_to_start
    ir = ItemRepository.new
    assert_equal [], ir.items
  end

  def test_new_item_added_to_item_array
    ir = ItemRepository.new
    hash = {
      :id          => 1,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => 2
    }
    ir.create(hash)
    assert_instance_of Item, ir.items[0]
  end

end
