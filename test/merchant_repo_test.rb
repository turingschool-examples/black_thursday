require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repo'

class MerchantRepoTest < Minitest::Test

  def test_it_initializes
    assert_instance_of MerchantRepository, MerchantRepository.new
  end

  def test_it_can_load_data_from_csv
    merch_repo = MerchantRepository.new

    assert_instance_of CSV, merch_repo.merchant_csv
  end

  def test_it_can_create_merchant_instances
    merch_repo = MerchantRepository.new

    assert_instance_of Merchant, merch_repo.merchant_queue.first
  end

  def test_it_can_reach_the_merchant_instances_through_all
    merch_repo = MerchantRepository.new

    assert_instance_of Merchant, merch_repo.all.first
  end

  def test_it_can_find_merchants_by_name
    merch_repo = MerchantRepository.new
    results = merch_repo.find_by_id(12334105)

    assert_equal "got", results
  end

end
