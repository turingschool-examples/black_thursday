require './test/test_helper'
require './lib/merchant_repository'
require './lib/merchant'
require 'pry'


class MerchantRepositoryTest < MiniTest::Test
  attr_reader :merch_1,
              :merch_2,
              :merch_3

  def setup
    @merch_1 = Merchant.new(:id => 1, :name => "Burger King")
    @merch_2 = Merchant.new(:id => 2, :name => "McDonalds")
    @merch_3 = Merchant.new(:id => 3, :name => "Wendys")
  end

  def test_it_has_no_merchants_when_initialized
    merchant = MerchantRepository.new()

    assert_equal [], merchant.all
  end

  def test_it_can_add_merchants
    mr = MerchantRepository.new
    mr.add_merchants(merch_1)
    mr.add_merchants(merch_2)
    mr.add_merchants(merch_3)

    assert_equal [merch_1, merch_2, merch_3], mr.all
  end

  def test_if_can_find_by_id
    mr = MerchantRepository.new
    mr.add_merchants(merch_1)
    mr.add_merchants(merch_2)
    mr.add_merchants(merch_3)

    assert_equal merch_3, mr.find_by_id(3)
  end

  def test_to_find_by_name
    mr = MerchantRepository.new
    mr.add_merchants(merch_1)
    mr.add_merchants(merch_2)
    mr.add_merchants(merch_3)

    assert_equal merch_1, mr.find_by_name("Burger King")
  end

  def test_to_find_by_all_by_name
    mr = MerchantRepository.new
    mr.add_merchants(merch_1)
    mr.add_merchants(merch_2)
    mr.add_merchants(merch_3)
    results = mr.find_all_by_name("Burger King")

    assert results.include?(merch_1)
  end

end
