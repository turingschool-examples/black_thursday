require_relative 'test_helper'
require './lib/merchant_repository'
require './lib/merchant'
require 'pry'

class MerchantRepositoryTest < Minitest::Test
  def test_that_merchant_repo_class_exist
    mr = MerchantRepository.new("./data/mini_merchants.csv")
    assert_instance_of MerchantRepository, mr
  end

  def test_it_can_load_csv_file
    mr = MerchantRepository.new("./data/mini_merchants.csv")
    assert mr
  end

  def test_merchant_repo_returns_array_of_all_known_merchant_instances
    mr = MerchantRepository.new("./data/mini_merchants.csv")
    assert_equal 100, mr.all.count
  end

  def test_merchant_repo_is_able_to_find_by_id
    mr = MerchantRepository.new("./data/mini_merchants.csv")
    assert mr.find_by_id(12334174)
  end

  def test_merchant_repo_returns_nil_when_it_cant_find_id
    mr = MerchantRepository.new("./data/mini_merchants.csv")
    assert_nil mr.find_by_id(12334861)
  end

  def test_merchant_repo_is_able_to_find_by_name
    mr = MerchantRepository.new("./data/mini_merchants.csv")
    assert mr.find_by_name("JUSTEmonsters")
  end

  def test_merchant_repo_returns_nil_if_no_name_is_found
    mr = MerchantRepository.new("./data/mini_merchants.csv")
    assert mr.find_by_name("MandyBlackShop")
  end

  def test_merchant_repo_can_supply_names_if_given_name_fragment
    mr = MerchantRepository.new("./data/mini_merchants.csv")
    assert_instance_of Array, mr.find_all_by_name("Man")
  end
end
