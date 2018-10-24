require_relative './helper'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'
class MerchantRepositoryTest < Minitest::Test
  def test_it_exists
    mr = MerchantRepository.new('./data/merchants.csv')
    assert_instance_of MerchantRepository, mr
  end

  def test_it_can_create_merchants
    mr = MerchantRepository.new('./data/merchants.csv')
    assert_equal 475, mr.merchants.count
  end

  def test_can_return_array_of_all_merchant_instances
    mr = MerchantRepository.new('./data/merchants.csv')
    mr.merchants
    assert_equal 475, mr.all.count
  end

  def test_can_find_by_id
    mr = MerchantRepository.new('./data/merchants.csv')
    mr.merchants
    assert_instance_of Merchant, mr.find_by_id('12334123')
  end

  def test_it_can_find_by_name
    mr = MerchantRepository.new('./data/merchants.csv')
    mr.merchants
    assert_instance_of Merchant, mr.find_by_name('GoldenRayPress')
  end

  def test_it_can_find_all_by_name
    mr = MerchantRepository.new('./data/merchants.csv')
    mr.merchants
    assert_equal [], mr.find_all_by_name('Leprechauns')
    assert_equal 1, mr.find_all_by_name('Golden').count
  end

  def test_it_can_create_merchant_with_attribute
    mr = MerchantRepository.new('./data/merchants.csv')
    mr.merchants
    assert_instance_of Merchant, mr.create('SalsSidekicks')
    assert_equal 'SalsSidekicks', mr.all.last.name
    assert_equal '12337412', mr.all.last.id
  end

  def test_it_can_update_merchant_attributes
    mr = MerchantRepository.new('./data/merchants.csv')
    mr.merchants
    mr.update('12334135', 'SilverSunPress')
    assert_equal 'SilverSunPress', mr.find_by_id('12334135').name
  end

  def test_can_delete_id
    mr = MerchantRepository.new('./data/merchants.csv')
    mr.merchants
    assert mr.all.any? { |merchant| merchant.id == '12337411' }
    mr.delete('12337411')
    refute mr.all.any? { |merchant| merchant.id == '12337411' }
  end
end
