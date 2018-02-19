require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def setup
    item_csv = './test/fixtures/item_repository_abreviated.csv'
    parent = 'parent'
    @ir = ItemRepository.new(item_csv, parent)
  end

  def test_it_exists
    assert_instance_of ItemRepository, @ir
    assert_equal 'parent', @ir.parent
  end

  def test_item_csv_parsed
    assert_equal 4, @ir.items.length
    assert_equal 263395237, @ir.items.first.id
  end
end
