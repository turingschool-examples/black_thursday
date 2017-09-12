require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repo'
require 'pry'

class MerchantRepoTest < MiniTest::Test

  def test_it_exists
    mr = MerchantRepo.new("./data/merchants.csv")

    assert_instance_of MerchantRepo, mr
  end

  def test_it_does_smtg
    mr = MerchantRepo.new("./data/merchants.csv")

    binding.pry
  end

end
