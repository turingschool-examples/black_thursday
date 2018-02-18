require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def test_it_exists
    item_list = './test/fixtures/item_repository_abreviated.csv'
    parent = 'parent'
    ir = ItemRepository.new(item_list, parent)

    assert_instance_of ItemRepository, ir
    assert_equal './test/fixtures/item_repository_abreviated.csv', ir.item_list
    assert_equal 'parent', ir.parent
    assert_equal [], ir.items
  end
end
