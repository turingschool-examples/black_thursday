# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_it_exists
    merchant_repository = MerchantRepository.new('./fixtures/merchants.csv')

    assert_instance_of MerchantRepository, merchant_repository
  end

  def test_a_merchant_repo_has_merchants
    merchant_repo = MerchantRepository.new('./fixtures/merchants.csv')

    assert_equal 8, merchant_repo.all.count
    assert_instance_of Array, merchant_repo.all
    assert merchant_repo.all.all? { |merchant| merchant.is_a?(Merchant) }
    assert_equal 'Shopin1901', merchant_repo.all.first.name
  end

  def test_it_can_find_merchant_by_id
    merchant_repo = MerchantRepository.new('./fixtures/merchants.csv')

    result = merchant_repo.find_by_id(1)

    assert_instance_of Merchant, result
    assert_equal 'Shopin1901', result.name
    assert_equal 1, result.id
  end

  def test_it_returns_nil_when_no_find_match
    merchant_repo = MerchantRepository.new('./fixtures/merchants.csv')

    result = merchant_repo.find_by_id(876)

    assert_nil result
  end
end
