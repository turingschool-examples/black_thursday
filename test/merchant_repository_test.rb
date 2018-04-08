require_relative 'test_helper'
require_relative '../lib/merchant_repository'

# merchant repository class
class MerchantRepositoryTest < Minitest::Test
  def setup
    @merchant_repository = MerchantRepository.new('./data/test_merchants.csv')
  end

  def test_merchant_repository_exists
    assert_instance_of MerchantRepository, @merchant_repository
  end

  def test_creating_an_index_of_merchants_from_data
    assert_instance_of Hash, @merchant_repository.by_id
    assert_instance_of Merchant, @merchant_repository.by_id['12334105']
    assert_instance_of Merchant, @merchant_repository.by_id['12334112']
    assert_instance_of Merchant, @merchant_repository.by_id['12334113']
    assert_instance_of Merchant, @merchant_repository.by_id['12334115']
    assert_instance_of Merchant, @merchant_repository.by_id['12334123']
    assert_instance_of Merchant, @merchant_repository.by_id['12334132']
    assert_instance_of Merchant, @merchant_repository.by_id['12334135']
  end
end
