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

end
