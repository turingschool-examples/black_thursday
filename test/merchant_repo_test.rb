require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_it_exists
    merchant_repository = MerchantRepository.new('./data/merchants.csv')
    assert_instance_of MerchantRepository, merchant_repository
  end
end