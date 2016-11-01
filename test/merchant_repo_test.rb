require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repo'
require 'pry'
class MerchantRepoTest < Minitest::Test
  def test_merchant_repo_class_exists
    assert_instance_of MerchantRepo, MerchantRepo.new
  end

  def test_merchant_repo_can_populate_with_merchant_objects
    merchant_repo = MerchantRepo.new
    parsed = DataParser.parse_data('./data/merchants.csv')
    assert_equal Merchant, merchant_repo.all.first.class
    assert_equal "2010-12-10", merchant_repo.all.first.created_at
    assert_equal "12334105", merchant_repo.all.first.id
    assert_equal "Shopin1901", merchant_repo.all.first.name
    assert_equal "2011-12-04", merchant_repo.all.first.updated_at
  end
end
