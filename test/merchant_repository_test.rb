require_relative 'test_helper'
require './lib/merchant_repository'
require 'csv'

class MerchantRepositoryTest < Minitest::Test

  def test_merchant_repository_class_exists
    merchant_repo = MerchantRepository.new("./data/merchants.csv")

    assert_instance_of MerchantRepository, merchant_repo
  end

  def test_load_from_csv_returns_array_of_merchants
    merchant_repo = MerchantRepository.new("./data/merchants.csv")

    refute_nil(merchant_repo.merchants)
  end

  def test_it_finds_merchant_by_id
    merchant_repo = MerchantRepository.new("./data/merchants.csv")
    merchant = merchant_repo.find_by_id(12334105)

    assert_equal "Shopin1901", merchant.name
  end






end
