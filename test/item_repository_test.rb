require_relative 'test_helper'
require './lib/item_repository'
require 'pry'

class ItemRepositoryTest < Minitest::Test
  def setup
    @ir = ItemRepository.new('./test/fixtures/items_truncated.csv')
  end

  def test_it_exists
    assert_instance_of ItemRepository, @ir
  end

  def test_it_has_items
    assert_equal 5, @ir.all.count
    assert_instance_of Array, @ir.all
    assert_instance_of Item, @ir.items[0]
    # assert(@ir.all.all?) { |item| item.is_a?(Item) }
  end
end
