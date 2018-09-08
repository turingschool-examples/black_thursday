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
    mr = MerchantRepo.new("./data/merchants.csv")
    assert_instance_of MerchantRepo, mr
  end

end
