require './test/test_helper'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def setup
    file_path  = './data/sample_data/items.csv'
    @item_repo = ItemRepository.new(file_path)
  end

  def test_item_repository_class_exists
    assert_instance_of ItemRepository, @item_repo
  end

  def test_all_method
    assert_instance_of Array, @item_repo.all
    assert_instance_of Item, @item_repo.all.first
    assert_equal '1', @item_repo.all.first.id
    assert_equal 'Eraser', @item_repo.all.last.name
  end

  def test_find_by_id_method
    assert_nil @item_repo.find_by_id('8')
    assert_instance_of Item, @item_repo.find_by_id('2')
    assert_equal 'Pen', @item_repo.find_by_id('3').name
  end

  def test_find_by_name
    assert_nil @item_repo.find_by_name('Satisfaction')
    assert_instance_of Item, @item_repo.find_by_name('Pencil')
    assert_instance_of Item, @item_repo.find_by_name('pEnCiL')
    assert_equal '1', @item_repo.find_by_name('pEnCiL').id
  end

  def test_find_all_with_description
    skip
    assert_equal [], @item_repo.find_all_with_description("qwijybo")
# or instances of Item where the supplied string appears
# in the item description (case insensitive)
  end

  def test_find_all_by_price
    skip
    assert_equal [], @item_repo.find_all_by_price("0012")
# or instances of Item where the supplied price exactly matches
  end

  def test_find_all_by_price_in_range
    skip
    assert_equal [], @item_repo.find_all_by_price_in_range("0012")
# or instances of Item where the supplied price is
# in the supplied range (a single Ruby range instance is passed in)
  end

  def test_find_all_by_merchant_id
    skip
    assert_equal [], @item_repo.find_all_by_merchant_id("2")
# or instances of Item where the supplied merchant ID
# matches that supplied
  end
end
