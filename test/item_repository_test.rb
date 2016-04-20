require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/item_repository'

class ItemRepositoryTest < Minitest::Test

  def setup
    item_data1 = ['263395237','510+ RealPush Icon Set',
                  'this is a test description','1200',
                  '12334141','2016-01-11 09:34:06 UTC',
                  '2007-06-04 21:35:10 UTC']
    item_data2 = ['263395617','Glitter scrabble frames',
                  'this is a different description','1300',
                  '12334185','2016-01-11 11:51:37 UTC',
                  '1993-09-29 11:56:40 UTC']
    item_data3 = ['263395721','Disney scrabble frames',
                  'This is another description','1300',
                  '12334185','2016-01-11 11:51:37 UTC',
                  '2008-04-02 13:48:57 UTC']
    @item1 = Item.new(item_data1)
    @item2 = Item.new(item_data2)
    @item3 = Item.new(item_data3)
    @item_repository = ItemRepository.new([])
    @item_repository.items = [@item1, @item2, @item3]
  end

  def test_all
    assert_equal [@item1, @item2, @item3], @item_repository.all
  end

  def test_find_by_id
    assert_equal @item2, @item_repository.find_by_id(263395617)
  end

  def test_find_by_id_invalid
    assert_equal nil, @item_repository.find_by_id(57394593)
  end

  def test_find_by_name
    assert_equal @item3, @item_repository.find_by_name("Disney scrabble Frames")
  end

  def test_find_by_name_nil
    assert_equal nil, @item_repository.find_by_name("wallapalooza")
  end

  def test_find_all_with_description_multiple
    assert_equal [@item1, @item2, @item3], @item_repository.find_all_with_description("description")
  end

  def test_find_all_with_description_singular
    assert_equal [@item3], @item_repository.find_all_with_description('another')
  end

  def test_find_all_with_description_empty
    assert_equal [], @item_repository.find_all_with_description('aloha')
  end

  def test_all_by_price
    assert_equal [@item1], @item_repository.find_all_by_price(12)
  end

  def test_all_by_price_multiple
    assert_equal [@item2, @item3], @item_repository.find_all_by_price(13)
  end

  def test_all_by_price_empty
    assert_equal [], @item_repository.find_all_by_price(1900)
  end

  def test_all_by_price_in_range
    assert_equal [@item1, @item2, @item3], @item_repository.find_all_by_price_in_range(10..15)
  end

  def test_all_by_price_in_range_false
    assert_equal [], @item_repository.find_all_by_price(20..40)
  end

  def test_find_all_by_merchant_id_single
    assert_equal [@item1], @item_repository.find_all_by_merchant_id(12334141)
  end

  def test_find_all_by_merchant_id_multiple
    assert_equal [@item2, @item3], @item_repository.find_all_by_merchant_id(12334185)
  end

  def test_find_all_by_merchant_id_nil
    assert_equal [], @item_repository.find_all_by_merchant_id(729563930)
  end

end
