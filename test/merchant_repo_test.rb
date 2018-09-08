require 'pry'
require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/sales_engine'
require_relative '../lib/csv_adaptor'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repo'

class MerchantRepoTest < Minitest::Test

  def test_it_exists
    mr = MerchantRepo.new("./data/merchants.csv")

    assert_instance_of MerchantRepo, mr
  end

end
