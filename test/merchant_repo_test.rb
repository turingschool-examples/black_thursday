require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repo'
require 'pry'

class MerchantRepoTest < Minitest::Test

  def test_it_initializes
    assert_instance_of MerchantRepository, MerchantRepository.new(self)
  end

  def test_it_can_load_data_from_csv
    merch_repo = MerchantRepository.new(self)

    assert_instance_of CSV, merch_repo.merchant_csv
  end

  def test_it_can_create_merchant_instances
    merch_repo = MerchantRepository.new(self)

    assert_instance_of Merchant, merch_repo.merchant_queue.first
  end

  def test_it_can_reach_the_merchant_instances_through_all
    merch_repo = MerchantRepository.new(self)

    assert_instance_of Merchant, merch_repo.all.first
  end

  def test_it_can_find_merchants_by_id
    merch_repo = MerchantRepository.new(self)
    results = merch_repo.find_by_id("12334105")

    assert_equal 1, results.count
    assert_equal "Shopin1901", results.first.name
  end

  def test_it_can_find_merchants_by_name
    merch_repo = MerchantRepository.new(self)
    results = merch_repo.find_by_name("Shopin1901")

    assert_equal 1, results.count
    assert_equal "12334105", results.first.id
  end

end
