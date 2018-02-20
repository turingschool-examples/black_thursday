# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_it_exists
    mr = MerchantRepository.new './test/fixtures/merchants.csv'

    assert_instance_of MerchantRepository, mr
  end

  def test_a_merchant_repo_has_merchants
    merchant_repo = MerchantRepository.new './test/fixtures/merchants.csv'

    assert_equal 9, merchant_repo.all.count
    assert_instance_of Array, merchant_repo.all
    assert merchant_repo.all.all? do |merchant|
      merchant.is_a? Merchant
    end
    assert_equal 'Shopin1901', merchant_repo.all.first.name
  end

  def test_it_can_find_merchant_by_id
    merchant_repo = MerchantRepository.new './test/fixtures/merchants.csv'

    result = merchant_repo.find_by_id 1

    assert_instance_of Merchant, result
    assert_equal 'Shopin1901', result.name
    assert_equal 1, result.id
  end

  def test_it_returns_nil_when_no_find_match
    merchant_repo = MerchantRepository.new './test/fixtures/merchants.csv'

    result = merchant_repo.find_by_id 876

    assert_nil result
  end

  def test_it_can_find_merchant_by_name
    merchant_repo = MerchantRepository.new './test/fixtures/merchants.csv'

    result = merchant_repo.find_by_name 'Candisart'

    assert_instance_of Merchant, result
    assert_equal 'Candisart', result.name
    assert_equal 2, result.id
  end

  def test_it_can_find_merchant_by_name_case_insensitive
    merchant_repo = MerchantRepository.new './test/fixtures/merchants.csv'

    result = merchant_repo.find_by_name 'lolamarleys'

    assert_instance_of Merchant, result
    assert_equal 'LolaMarleys', result.name
    assert_equal 4, result.id
  end

  def test_it_can_find_an_array_of_matches_by_name_fragment
    merchant_repo = MerchantRepository.new './test/fixtures/merchants.csv'

    result = merchant_repo.find_all_by_name 'mini'

    assert_instance_of Array, result
    assert_instance_of Merchant, result[0]
    assert_instance_of Merchant, result[1]
    assert_equal 'MiniatureBikez', result[0].name
    assert_equal 'Miniaturepeople', result[1].name
  end
end
