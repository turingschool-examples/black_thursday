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
    skip
    assert_instance_of Array, @item_repo.all
    assert_instance_of Item, @item_repo.all.first
    assert_equal '12334105', @item_repo.all.first.id
    assert_equal 'LolaMarleys', @item_repo.all.last.name
  end

  def test_find_by_id_method
    skip
    assert_nil @merch_repo.find_by_id('8')
    assert_instance_of Merchant, @merch_repo.find_by_id('12334105')
    assert_equal 'Shopin1901', @merch_repo.find_by_id('12334105').name
  end
# find_by_name - returns either nil or an instance of Item having done a case insensitive search
# find_all_with_description - returns either [] or instances of Item where the supplied string appears in the item description (case insensitive)
# find_all_by_price - returns either [] or instances of Item where the supplied price exactly matches
# find_all_by_price_in_range - returns either [] or instances of Item where the supplied price is in the supplied range (a single Ruby range instance is passed in)
# find_all_by_merchant_id - returns either [] or instances of Item where the supplied merchant ID matches that supplied
end
