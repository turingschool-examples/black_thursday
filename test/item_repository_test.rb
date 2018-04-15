require_relative 'test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  def test_exists
    item_repo = ItemRepository.new('./test/fixtures/items.csv', nil,)
    assert_instance_of ItemRepository, item_repo
  end

  def test_can_load_item
    item_repo = ItemRepository.new('./test/fixtures/items.csv', nil)
    assert_instance_of Array, item_repo.items
    assert_equal 263395237, item_repo.items.first.id
    # assert_equal (2016-01-11 09:34:06 UTC), item_repo.items.first.created_at
  end

  def test_it_loads_items
    item_repo = ItemRepository.new('./test/fixtures/items.csv', nil)

    assert item_repo.all.all? {|item|item.kind_of?(Item)}
    assert_equal 1367, item_repo.all.count
  end

  def test_it_can_find_by_id
    item_repo = ItemRepository.new('./test/fixtures/items.csv', nil)

    result = item_repo.find_by_id(263395237)
    assert_instance_of Item, result
    assert_equal '510+ RealPush Icon Set', result.name
  end

  def test_it_can_return_nil_if_no_id_matched
    item_repo = ItemRepository.new('./test/fixtures/items.csv', nil)

    result = item_repo.find_by_id(0000000)
    assert_nil result
  end

  def test_it_can_fiind_by_name
    item_repo = ItemRepository.new('./test/fixtures/items.csv', nil)

    result = item_repo.find_by_name('510+ realPush Icon Set')

    assert_equal 263395237, result.id
  end

  def test_it_can_find_all_by_description
    item_repo = ItemRepository.new('./test/fixtures/items.csv', nil)

    result = item_repo.find_all_with_description('Disney')
    assert_instance_of Array, result
    assert result.all? {|item|item.is_a?(Item)}
    assert_equal 263395721, result.first.id
  end

  def test_it_can_retun_empty_array_when_no_description_matched
    item_repo = ItemRepository.new('./test/fixtures/items.csv', nil)

    result = item_repo.find_all_with_description('manoj')
    assert_equal [], result
  end

  def test_find_all_by_price_method_return_instance_of_item
    item_repo = ItemRepository.new('./test/fixtures/items.csv', nil)
    result = item_repo.find_all_by_price(1300)

    assert_instance_of Array, result
    assert result.all? {|item|item.is_a?(Item)}

    assert_equal 0, result.count
  end

  def test_it_can_find_all_by_price_range
    item_repo = ItemRepository.new('./test/fixtures/items.csv', nil)

    result = item_repo.find_all_by_price_in_range((1..100))

    assert_instance_of Array, result
    assert result.all? {|item|item.is_a?(Item)}

    assert_equal 1090, result.count
  end

  def test_it_can_find_merchant_id
    item_repo = ItemRepository.new('./test/fixtures/items.csv', nil)

    result = item_repo.find_all_by_merchant_id(12334141)
    assert_equal '510+ RealPush Icon Set', result.first.name
    assert_instance_of Item, result.first
  end

  def test_find_all_merchant_id_returns_empty_array_for_unknown_merchant_id
    item_repo = ItemRepository.new('./test/fixtures/items.csv', nil)

    result = item_repo.find_all_by_merchant_id(0000000)
    assert_equal [], result
  end

  def test_creates_attributes
    skip
    item_repo = ItemRepository.new('./test/fixtures/items.csv', nil)

    result = item_repo.create({unit_price: 1.5, merchant_id: 12345, name: 'Mango', description: 'Tasty fruit'})
    assert_equal 'Mango', result.last.name
    result1 = item_repo.find_by_name('Mango')
    assert_equal 12345, result1.merchant_id
    assert_equal true, item_repo.find_all_by_price(15).include?(result1)
  end

  def test_updates_merchant_instance
    item_repo = ItemRepository.new('./test/fixtures/items.csv', nil)
    result = item_repo.create({unit_price: 15, merchant_id: 12345, name: 'Mango', description: 'Tasty fruit'})
    assert_equal 'Mango', result.last.name
    assert_equal 263567475, result.last.id

    item_repo.update(263567475, {name: 'dinosaur', description: 'extincted', unit_price: 1000})

    result = item_repo.find_by_id(263567475)
    assert_equal 'dinosaur', result.name
    assert_equal 1000, result.unit_price
    assert_equal 'extincted', result.description
    assert_equal 12345, result.merchant_id
  end

  def test_we_can_delete_item
    item_repo = ItemRepository.new('./test/fixtures/items.csv', nil)

    assert_equal 1367, item_repo.items.count
    result = item_repo.create({unit_price: 15, merchant_id: 12345, name: 'Mango', description: 'Tasty fruit'})
    assert_equal 263567475, item_repo.items.last.id

    assert_equal 1368, item_repo.items.count

    result = item_repo.delete(263567475)
    assert_equal 1367, item_repo.items.count

    assert_equal 'Mango', result.name # this is the name of deleted item
    assert_equal 263567475, result.id # thid id the of deleted item
  end
end
