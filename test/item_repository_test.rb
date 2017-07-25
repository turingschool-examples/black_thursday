require './lib/item_repository'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'

class ItemRepositoryTest < Minitest::Test

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

end
