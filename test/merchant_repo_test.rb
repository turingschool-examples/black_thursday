require_relative 'test_helper'
require_relative '../lib/merchant_repo'

class MerchantRepoTest < Minitest::Test
  def test_merchant_repo_class_exists
    assert_instance_of MerchantRepo, MerchantRepo.new('./data/merchants.csv')
  end

  def test_merchant_repo_can_populate_with_merchant_objects
    merchant_repo = MerchantRepo.new('./data/merchants.csv')
    assert_equal Merchant, merchant_repo.all.first.class
    assert_equal "2010-12-10", merchant_repo.all.first.created_at
    assert_equal 12334105, merchant_repo.all.first.id
    assert_equal "Shopin1901", merchant_repo.all.first.name
    assert_equal "2011-12-04", merchant_repo.all.first.updated_at
  end

  def test_merchant_repo_can_find_by_id
    merchant = MerchantRepo.new('./data/merchants.csv').find_by_id(12334105)
    assert_equal 12334105, merchant.id
  end

  def test_merchant_repo_returns_nil_when_given_fake_data
    merchant = MerchantRepo.new('./data/merchants.csv').find_by_id(77777777)
    assert_equal nil, merchant
  end

  def test_merchant_repo_can_find_by_name
    merchant = MerchantRepo.new('./data/merchants.csv').find_by_name("Shopin1901")
    assert_equal "Shopin1901", merchant.name
  end

  def test_merchant_repo_can_find_all_by_name
    merchant = MerchantRepo.new('./data/merchants.csv').find_all_by_name("gifts").to_s
    assert merchant.include?("ExecutiveGiftShoppe")
    assert merchant.include?("SoftAngelGifts")
    assert merchant.include?("ArgyllHandmadeGifts")
    refute merchant.include?("ApplePie")
  end
end
