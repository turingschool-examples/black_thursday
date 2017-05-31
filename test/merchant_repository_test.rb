require_relative 'test_helper'
require 'csv'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_it_can_return_ids
    skip
    merchant = MerchantRepository.new
    expected = sanitized_merchants
    actual = merchant[:id]

    assert_equal expected, actual
  end

  def test_it_returns_merchant_instances
    skip
    merchant = MerchantRepository.new

  end

  def test_it_opens_csv
    merchant = MerchantRepository.new
    actual = merchant.all_merchant_data.class
    expected = CSV

    assert_equal expected, actual
  end
end
