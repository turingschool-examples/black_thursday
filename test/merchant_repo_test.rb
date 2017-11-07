require_relative 'test_helper'
require_relative "../lib/merchant_repo"

class MerchantRepoTest < Minitest::Test

  def test_it_initializes
    assert_instance_of MerchantRepository, MerchantRepository.new(self, "./data/merchants.csv")
  end

  def test_it_can_create_merchant_instances
    merch_repo = MerchantRepository.new(self, "./data/merchants.csv")

    assert_instance_of Merchant, merch_repo.merchants.first
  end

  def test_it_can_reach_the_merchant_instances_through_all
    merch_repo = MerchantRepository.new(self, "./data/merchants.csv")

    assert_instance_of Merchant, merch_repo.all.first
  end

  def test_it_can_find_merchants_by_id
    merch_repo = MerchantRepository.new(self, "./data/merchants.csv")
    results = merch_repo.find_by_id(12334105)

    assert_equal "Shopin1901", results.name
  end

  def test_find_by_id_can_return_nil
    merch_repo = MerchantRepository.new(self, "./data/merchants.csv")
    results = merch_repo.find_by_id("999999")

    assert_nil results
  end

  def test_it_can_find_merchants_by_name
    merch_repo = MerchantRepository.new(self, "./data/merchants.csv")
    results = merch_repo.find_by_name("Shopin1901")

    assert_equal 12334105, results.id
  end

  def test_find_by_name_can_return_nil
    merch_repo = MerchantRepository.new(self, "./data/merchants.csv")
    results = merch_repo.find_by_name("NotARealShop")

    assert_nil results
  end

  def test_it_can_find_merchants_by_partial_names
    merch_repo = MerchantRepository.new(self, "./data/merchants.csv")
    results = merch_repo.find_all_by_name("Shop")

    assert_equal 26, results.count
    assert_equal "WoodleyShop", results[5].name
  end

  def test_find_by_partial_name_can_return_an_empty_array
    merch_repo = MerchantRepository.new(self, "./data/merchants.csv")
    results = merch_repo.find_all_by_name("XXXXXX")

    assert_equal 0, results.count
    assert_equal [], results
  end

end
