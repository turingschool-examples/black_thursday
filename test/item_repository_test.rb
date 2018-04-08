require './test/test_helper'
require_relative '../lib/item_repository'

class ItemRepositoryTest < Minitest::Test
  attr_reader :item_repository
  def setup
    sales_engine = SalesEngine.from_csv(
      items: './data/items.csv',
      merchants: './data/merchants.csv'
    )
    @item_repository = sales_engine.items
  end

  def test_it_exists
    assert_instance_of MerchantRepository, item_repository
  end

  def test_it_can_create_a_new_item_instance
    skip
    attributes = ''
    item_repository.create(attributes)
    assert_equal [''], item_repository.all
  end

  def test_it_can_find_specified_item_by_id
    skip
    attributes = ''
    item_repository.create(attributes)
    assert_equal '', item_repository.find_by_id(id)
  end

  def test_it_can_find_specified_item_by_name
    skip
    attributes = ''
    item_repository.create(attributes)
    assert_equal '', item_repository.find_by_name(name)
  end

  def test_it_can_find_all_matching_items_that_contain_description
    skip
    attributes = ''
    item_repository.create(attributes)
    assert_equal '', item_repository.find_all_with_description(description)
  end

  def test_it_can_find_all_items_of_specified_price
    skip
    attributes = ''
    item_repository.create(attributes)
    assert_equal '', item_repository.find_all_by_price(price)
  end

  def test_it_can_find_all_items_in_a_specified_price_range
    skip
    attributes = ''
    item_repository.create(attributes)
    assert_equal '', item_repository.find_all_by_price_in_range(range)
  end

  def test_it_can_find_all_items_matching_with_merchant_id
    skip
    attributes = ''
    item_repository.create(attributes)
    assert_equal '', item_repository.find_all_by_merchant_id(merchant_id)
  end

  def test_it_can_update_an_established_item
    skip
    attributes = ''
    item_repository.create(attributes)
    item_repository.update(id, attributes)
    assert_equal '', item_repository.find_by_id(id)
  end

  def test_it_can_delete_an_established_item_from_the_list_by_id
    skip
    attributes = ''
    item_repository.create(attributes)
    item_repository.delete(id)
    assert_equal [], item_repository.all
  end
end
