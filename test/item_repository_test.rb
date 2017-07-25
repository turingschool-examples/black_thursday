require './lib/item_repository'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'

class ItemRepositoryTest < Minitest::Test

  def setup
    @item_r = ItemRepository.new

    hash_one = {merchant_id: 7, description: "Brown and tasty",
                id: 123, name: "Chocolate", unit_price: 315     }
    hash_two = {merchant_id: 2, description: "Red and tasty",
                id: 123, name: "Cherry", unit_price: 210        }
    hash_three = {merchant_id: 5, description: "Brown and tasty",
                id: 124, name: "Coconut", unit_price: 400       }
    hash_four = {merchant_id: 5, description: "Green",
                id: 125, name: "Apple", unit_price: 115         }
    @item_r.add_data(hash_one)
    @item_r.add_data(hash_two)
    @item_r.add_data(hash_three)
    @item_r.add_data(hash_four)
  end


  def test_it_is_initialized
    ir = ItemRepository.new

    assert ir
    assert_instance_of ItemRepository, ir
  end

  def test_it_can_be_added_to
    ir = ItemRepository.new

    hash_one = {
    id: 12334113, name: "MiniatureBikez"}
    hash_two = {
    id: 12334115, name: "LolaMarleys"   }
    ir.add_data(hash_one)
    ir.add_data(hash_two)

    assert_equal 12334113, ir.items.first.id
    assert_equal 12334115, ir.items.last.id
    assert_equal "MiniatureBikez", ir.items.first.name
    assert_equal "LolaMarleys", ir.items.last.name
  end

  def test_all_is_working
    assert_equal 4, @item_r.items.count
    assert_equal 7, @item_r.items.first.merchant_id
    assert_equal "Chocolate", @item_r.items.first.name
    assert_equal 115, @item_r.items.last.unit_price
  end

  def test_find_by_id_working
    assert_equal @item_r.items.

end
