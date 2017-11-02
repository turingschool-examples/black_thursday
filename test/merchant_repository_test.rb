require_relative 'test_helper'
require 'csv'
require './lib/sales_engine'
require './lib/merchant_repository'
require 'pry'

class MerchantRepositoryTest < Minitest:: Test
  def test_return_array
    result = MerchantRepository.new("")

    assert_instance_of MerchantRepository, result
  end

  def test_returns_array_of_all_Merchant_instances
    mr = MerchantRepository.new("")
    mr.create_merchant({
      :merchants => "./test/fixtures/merchants_5lines.csv",
    })
    result = mr.all

    assert_equal 6, result.count
  end

  def test_returns_instance_of_Merchant_from_matching_id
    mr = MerchantRepository.new("")
    mr.create_merchant({
      :merchants => "./test/fixtures/merchants_5lines.csv",
    })
    row1 = mr.merchants[3]
    row2 = mr.merchants[2]

    assert_equal row1, mr.find_by_id(12334115)
    assert_equal row2, mr.find_by_id(12334113)
  end

  def test_it_creates_merchant
    mr = MerchantRepository.new("")
    mr.create_merchant({
      :merchants => "./test/fixtures/merchants_5lines.csv",
    })

    assert_equal "Shopin1901", mr.merchants[0].name
    assert_equal "12334112", mr.merchants[1].id
  end

  def test_returns_instance_of_Merhant_from_name
    mr = MerchantRepository.new("")
    mr.create_merchant({
      :merchants => "./test/fixtures/merchants_5lines.csv",
    })
    result = mr.find_by_name("Keckenbauer")
    merchant = mr.merchants[4]

    assert_equal merchant, result
  end

  def test_returns_all_instances_of_Merchant_sorted_by_name
    mr = MerchantRepository.new("")
    mr.create_merchant({
      :merchants => "./test/fixtures/merchants_5lines.csv",
    })
    result = mr.find_all_by_name("LolaMarleys")
    merchants = [mr.merchants[3],mr.merchants[5]]

    assert_equal merchants, result
  end
end
