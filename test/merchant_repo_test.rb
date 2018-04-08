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
end
