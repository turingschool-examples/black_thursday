require_relative 'test_helper'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'
# require_relative './fixtures/merchants_list_truncated.csv'

class MerchantRepositoryTest < Minitest::Test
  def test_it_exists
    merchant_repository = MerchantRepository.new('test_path', 'sales_engine')

    assert_instance_of MerchantRepository, merchant_repository
  end

  def test_for_initialized_arguments
    merchant_repository = MerchantRepository.new('test_path', 'sales_engine')

    assert_equal 'test_path', merchant_repository.merchant_csv_path
    assert_equal 'sales_engine', merchant_repository.parent
  end

  def test_for_all_method
    se = SalesEngine.new
    se.from_csv(items: './data/items.csv',
                merchants: './test/fixtures/merchants_list_truncated.csv')
    mr = se.merchants

    assert_instance_of Array, mr.all
    assert mr.all[0].is_a?(Merchant)
    assert_equal 6, mr.all.count
  end

  def test_for_find_by_id_method
    se = SalesEngine.new
    se.from_csv(items: './data/items.csv',
                merchants: './test/fixtures/merchants_list_truncated.csv')
    mr = se.merchants

    assert_nil mr.find_by_id('10101010')
  end
end
