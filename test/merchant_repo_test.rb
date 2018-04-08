require_relative 'test_helper'
require_relative '../lib/merchant_repo'

class MerchantRepoTest < Minitest::Test
  attr_reader :mr

  def setup
    @mr = MerchantRepo.new("./data/merchants.csv")
  end

  def test_it_exists
    assert_instance_of MerchantRepo, mr
  end

  def test_it_returns_all
    assert_equal 475, mr.all.count
    assert_instance_of Array, mr.all
    assert_instance_of Merchant, mr.all.sample
  end
end
