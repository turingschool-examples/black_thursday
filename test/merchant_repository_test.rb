require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/'

class MerchantRepositoryTest < Minitest::Test
  def setup
    @merchant_repository = MerchantRepository.new
  end

  def test_merchant_repository_exists
    assert_instance_of MerchantRepository, @merchant_repository
  end
end
