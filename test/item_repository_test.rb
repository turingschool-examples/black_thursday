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
    assert_equal 263_395_237, @ir.items.first.id
  end

  def test_all_items
    assert_equal 4, @ir.all.length
    assert @ir.all[3].is_a?(Item)
    assert @ir.all[0].description.include?('googlepicasa')
  end

  def test_find_by_id
    assert_nil @ir.find_by_id(111)
    assert_equal 263_395_237, @ir.find_by_id(263_395_237).id
  end

  def test_find_by_name
    assert_nil @ir.find_by_name('help meadsfadsf')
    assert_equal '510+ RealPush Icon Set', @ir.find_by_name('510+ RealPush Icon Set').name
  end

  def test_find_all_with_description
    assert_equal [], @ir.find_all_with_description('help me')
    assert_equal 1, @ir.find_all_with_description('Free standing woo').length
  end
end
