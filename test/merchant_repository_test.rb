require_relative 'test_helper'
require_relative '../lib/merchant_repository'
require 'minitest/autorun'
require 'minitest/pride'

class MerchantRepositoryTest < Minitest::Test

  def test_it_pulls_csv_info_from_merchants
    mr = MerchantRepository.new("./data/merchants.csv")

    assert_equal 476, mr.from_csv("./data/merchants.csv").count
  end

  def test_it_returns_array_of_all_merchants
    mr = MerchantRepository.new("./data/merchants.csv")

    assert_equal 476, mr.all.count
  end

  def test_it_can_find_by_id
    mr = MerchantRepository.new("./data/merchants.csv")

    assert_instance_of Merchant, mr.find_by_id
    assert_equal 12334174, mr.find_by_id.id
  end

  def test_it_can_find_by_name
    mr = MerchantRepository.new("./data/merchants.csv")

    assert_equal "BowlsByChris", mr.find_by_name.name
  end

  def test_it_can_find_all_by_name
    mr = MerchantRepository.new("./data/merchants.csv")

    assert_instance_of Array, mr.find_all_by_name
    assert_equal "RigRanch", mr.find_all_by_name.name
  end

  def test_it_can_find_all_by_fragment_of_name
    mr = MerchantRepository.new("./data/merchants.csv")

    mr.find_all_by_name("Rig")

    assert_equal "RigRanch", mr.find_all_by_name.name
  end
end
