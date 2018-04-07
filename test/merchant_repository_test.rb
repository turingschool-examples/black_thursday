require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/'

class MerchantRepositoryTest < Minitest::Test
  def setup
    @merchant_repository = MerchantRepository.new('../data/merchants.csv')
  end

  def test_merchant_repository_exists
    assert_instance_of MerchantRepository, @merchant_repository
  end

  def test_merchant_repository_can_have_data_file_attribute
    assert_equal '../data/merchatns.csv', @merchant_repository.data_file
  end
end
