require_relative 'test_helper'
require 'csv'
require './lib/sales_engine'
require './lib/merchant_repository'
require 'pry'

class MerchantRepositoryTest < Minitest:: Test

  def test_it_creates_merchant
    mr = MerchantRepository.new
    mr.create_merchant({
      :merchants => "./data/merchants_5lines.csv",
    })
    assert_equal "Shopin1901", mr.merchant_store[0][:name]
  end

  def test_return_array
    skip
    result = MerchantRepository.new

    assert_instance_of MerchantRepository, result
  end

  def test_returns_array_of_all_Merchant_instances
    skip
    mr = MerchantRepository.new
    result = mr.merchants

    assert_equal [??], result
  end

  def test_returns_instance_of_Merchant_from_matching_id
    skip
    mr = MerchantRepository.new
    result = mr.merchants[:id]

    assert_equal 45678, result
  end

  def test_returns_instance_of_Merhant_from_name
    skip
    mr = MerchantRepository.new
    result = mr.all_merchants(name)

    assert_equal "name", result
  end

  def test_returns_all_instances_of_Merchant_sorted_by_name
    skip
    mr = MerchantRepository.new
    result = mr.all_merchants

  end








end
