# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_it_exists
    merchant_repository = MerchantRepository.new('./data/merchants.csv')

    assert_instance_of MerchantRepository, merchant_repository
  end

  def test_a_merchant_repo_has_merchants
    merchant_repo = MerchantRepository.new('./test/fixtures/merchants.csv')

    assert_equal 8, merchant_repo.all.count
    assert_instance_of Array, merchant_repo.all
    assert merchant_repo.all.all? { |merchant| merchant.is_a?(Merchant) }
    assert_equal 'Shopin1901', merchant_repo.all.first.name
  end
end
