require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repo'
require './lib/merchant'
require 'pry'
#is it require relative everywhere or just in the sales engine?
# change all the requires to require relative

class MerchantRepoTest < Minitest::Test

  def test_it_exists
    mr = MerchantRepo.new("./test/fixtures/merchants.csv")
    assert_instance_of MerchantRepo, mr
  end

  def test_a_merchant_repo_has_merchants
    mr = MerchantRepo.new("./test/fixtures/merchants.csv")

    assert_equal 6, mr.all.count
    assert_instance_of Array, mr.all
    assert mr.all.all? { |merchant| merchant.is_a?(Merchant)}
    assert_equal "Shopin1901", mr.all.first.name
  end

  def test_it_can_find_a_merchant_by_id
    mr = MerchantRepo.new("./test/fixtures/merchants.csv")
    result = mr.find_by_id(1)
    assert_instance_of Merchant, result
    assert_equal "Shopin1901", result.name
    assert_equal 1, result.id
  end

  def test_returns_nil_if_no_match_found
    mr = MerchantRepo.new("./test/fixtures/merchants.csv")

    result = mr.find_by_id(289312)

    assert_nil result
  end

end
