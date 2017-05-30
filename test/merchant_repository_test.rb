require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'
require 'pry'


class MerchantRepositoryTest < MiniTest::Test

  def test_can_call_all_on_merchants
    merchant = MerchantRepository.new

    assert_equal [], merchant.all
  end

  def test_it_can_find_by_id
    merchant = MerchantRepository.new

    assert_equal nil, merchant.find_by_id
  end

  def test_if_can_find_by_name
    merchant = MerchantRepository.new

    assert_equal nil, merchant.find_by_name
  end

  def test_to_find_all_by_name
    merchant = MerchantRepository.new

    assert_equal [], merchant.find_all_by_name
  end






end
