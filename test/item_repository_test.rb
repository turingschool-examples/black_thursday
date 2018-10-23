require './lib/item_repository'
require './lib/item'
require 'minitest/autorun'
require 'minitest/pride'

class ItemRepositoryTest < Minitest::Test
  def setup
    @ir = ItemRepository.new

    @merchant_1 = Item.new(id: 1, name: "Turing School")
    @merchant_2 = Item.new(id: 2, name: "Coding Dojo")
    @merchant_3 = Item.new(id: 3, name: "General Assembly")
  end

  def test_it_exists
    assert_instance_of ItemRepository, @ir
  end

  def test_it_creates_a_merchant_instance
    assert_empty @ir.instances

    @ir.create(id: 1, name: "Turing School")
    @ir.create(id: 2, name: "Coding Dojo")
    @ir.create(id: 3, name: "General Assembly")

    assert_equal 3, @ir.instances.count
    assert diff [@merchant_1, @merchant_2, @merchant_3], @ir.instances
  end

  def test_find_all_with_description_returns_empty_array_if_none_found
    skip
  end

  def test_find_all_with_description_returns_matching_merchants
    skip
  end
end
