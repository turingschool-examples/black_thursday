require './test/test_helper'
require './lib/item_repository'

# Tests Item Repository
class ItemRepositoryTest < Minitest::Test
  def setup
    file_path  = './data/sample_data/items.csv'
    item_1     = mock
    item_2     = mock
    sales_eng  = stub(find_item_merchant: [item_1, item_2])
    @item_repo = ItemRepository.new(file_path, sales_eng)
  end

  def test_item_repository_class_exists
    assert_instance_of ItemRepository, @item_repo
  end

  def test_merchant_repository_adds_self_to_merchant
    assert_equal @item_repo, @item_repo.all.first.parent
  end

  def test_all_method
    assert_instance_of Array, @item_repo.all
    assert_instance_of Item, @item_repo.all.first
    assert_equal 1, @item_repo.all.first.id
    assert_equal 'Garbage', @item_repo.all.last.name
  end

  def test_find_by_id_method
    assert_nil @item_repo.find_by_id(11)
    assert_instance_of Item, @item_repo.find_by_id(2)
    assert_equal 'Pen', @item_repo.find_by_id(3).name
  end

  def test_find_by_name
    assert_nil @item_repo.find_by_name('Satisfaction')
    assert_instance_of Item, @item_repo.find_by_name('Pencil')
    assert_instance_of Item, @item_repo.find_by_name('pEnCiL')
    assert_equal 1, @item_repo.find_by_name('pEnCiL').id
  end

  def test_find_all_with_description
    actual = @item_repo.find_all_with_description('write things')

    assert_equal [], @item_repo.find_all_with_description('qwijybo')
    assert_equal 3, actual.length
    assert_instance_of Item, actual.first
  end

  def test_find_all_by_price
    actual = @item_repo.find_all_by_price(12.99)

    assert_equal [], @item_repo.find_all_by_price(0.12)
    assert_equal 2, actual.length
    assert_instance_of Item, actual.first
  end

  def test_find_all_by_price_in_range
    actual = @item_repo.find_all_by_price_in_range(11.0..20.0)

    assert_equal [], @item_repo.find_all_by_price_in_range(0..10.0)
    assert_equal 8, actual.length
    assert_instance_of Item, actual.first
  end

  def test_find_all_by_merchant_id
    actual = @item_repo.find_all_by_merchant_id(123_341_05)

    assert_equal [], @item_repo.find_all_by_merchant_id(2)
    assert_equal 3, actual.length
    assert_instance_of Item, actual.first
  end

  def test_it_asks_parent_for_items
    assert_instance_of Mocha::Mock, @item_repo.merchant('id')[0]
  end

  def test_inspect
    expected = '#<ItemRepository 10 rows>'
    assert_equal expected, @item_repo.inspect
  end
end
