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
                id: 125, name: "Apple", unit_price: 210         }
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
    save = @item_r.find_by_id(123)
    assert_instance_of Item, save
    assert_equal 2, save.merchant_id
    assert_equal "Cherry", save.name
  end

  def test_find_by_name_working
    save = @item_r.find_by_name("Coconut")
    assert_instance_of Item, save
    assert_equal 5, save.merchant_id
    assert_equal "Brown and tasty", save.description
    assert_equal "Coconut", save.name
  end

  def test_find_all_with_description_working_for_one_entry
    list = @item_r.find_all_with_description("green")
    assert_instance_of Item, list.first
    assert_equal 1, list.count
    assert_equal "Apple", list.first.name
    assert_equal 5, list.first.merchant_id
  end

  def test_find_all_with_description_working_for_multiple_entries
    list = @item_r.find_all_with_description("tasty")
    assert_equal 3, list.count
    assert_equal "Coconut", list.last.name
    assert_equal "Chocolate", list.first.name
    assert_equal "Cherry", list[1].name
  end

  def t


end
