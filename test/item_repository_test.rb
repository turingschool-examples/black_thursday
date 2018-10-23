require './lib/item_repository'
require './lib/merchant'
require 'minitest/autorun'
require 'minitest/pride'

class ItemRepositoryTest < Minitest::Test
  def setup
    @ir = ItemRepository.new
  end

  def test_it_exists
    assert_instance_of ItemRepository, @ir
  end

  def test_it_creates_a_merchant_instance
    assert_empty @ir.instances

    
    # Merchant.new(id: 1, name: "Turing School")
    # @merchant_2 = Merchant.new(id: 2, name: "Coding Dojo")
    # @merchant_3 = Merchant.new(id: 3, name: "General Assembly")
  end

  def test_find_all_with_description_returns_empty_array_if_none_found
    skip
  end

  def test_find_all_with_description_returns_matching_merchants
    skip
  end
end
