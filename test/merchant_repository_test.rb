require './test/test_helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchant_repository
  def setup
    sales_engine = SalesEngine.from_csv(
      items: './data/items.csv',
      merchants: './data/merchants.csv'
    )
    @merchant_repository = sales_engine.merchants
  end

  def test_it_exists
    assert_instance_of MerchantRepository, merchant_repository
  end

  def test_it_can_create_a_new_merchant_instance
    skip
    attributes = ''
    merchant_repository.create(attributes)
    assert_equal [''], merchant_repository.all
  end

  def test_it_can_find_specified_merchant_by_id
    skip
    attributes = ''
    merchant_repository.create(attributes)
    assert_equal '', merchant_repository.find_by_id(id)
  end

  def test_it_can_find_specified_merchant_by_name
    skip
    attributes = ''
    merchant_repository.create(attributes)
    assert_equal '', merchant_repository.find_by_name(name)
  end

  def test_it_can_find_all_matching_merchants_that_contain_specified_string
    skip
    attributes = ''
    merchant_repository.create(attributes)
    assert_equal '', merchant_repository.find_all_by_name(name)
  end

  def test_it_can_update_an_established_merchant
    skip
    attributes = ''
    merchant_repository.create(attributes)
    merchant_repository.update(id, attributes)
    assert_equal '', merchant_repository.find_by_id(id)
  end

  def test_it_can_delete_an_established_merchant_from_the_list_by_id
    skip
    attributes = ''
    merchant_repository.create(attributes)
    merchant_repository.delete(id)
    assert_equal [], merchant_repository.all
  end
end
