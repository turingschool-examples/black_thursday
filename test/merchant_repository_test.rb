require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository.rb'


class MerchantRepositoryTest < Minitest::Test
  def test_it_exists
    merchant_repository = MerchantRepository.new("./test/fixtures/merchants.csv")

    assert_instance_of MerchantRepository, merchant_repository
  end

  def test_a_merchant_repo_has_merchants
    merchant_repository = MerchantRepository.new("./test/fixtures/merchants.csv")

    assert_equal 4, merchant_repository.all.count
    assert_instance_of Array, merchant_repository.all
    assert merchant_repository.all? { |merchant| merchant.is_a?(Merchant)}
    assert_equal "Shopin1901", merchant_repository.all.first.name
  end
end
