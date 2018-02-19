require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository.rb'


class MerchantRepositoryTest < Minitest::Test
  def test_it_exists
    merchant_repository = MerchantRepository.new("./test/fixtures/merchants.csv")

    assert_instance_of MerchantRepository, merchant_repository
  end

  def test_merchant_repo_has_merchants
    merchant_repository = MerchantRepository.new("./test/fixtures/merchants.csv")

    assert_equal 4, merchant_repository.all.count
    assert_instance_of Array, merchant_repository.all
    assert merchant_repository.all { |merchant| merchant.is_a?(Merchant)}
    assert_equal "Shopin1901", merchant_repository.all.first.name
  end

  def test_it_can_find_merchant_by_id
    merchant_repository = MerchantRepository.new("./test/fixtures/merchants.csv")

    result = merchant_repository.find_by_id(1)

    assert_instance_of Merchant, result
    assert_equal "Shopin1901", result.name
    assert_equal 1, result.id
  end

  def test_it_returns_nil_when_no_find_match
    merchant_repository = MerchantRepository.new("./test/fixtures/merchants.csv")

    result = merchant_repository.find_by_id
  end
end
