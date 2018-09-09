require './test/minitest_helper'
require './lib/merchant_repository'

class MerchantTest<Minitest::Test

def test_it_exists
  mr = MerchantRepository.new("./data/merchants.csv")

  assert_instance_of MerchantRepository, mr
end

def test_merchant_repo_has_merchants
  mr = MerchantRepository.new("./data/merchants.csv")

  assert_equal 475 , mr.all.count
  assert_instance_of Array, mr.all
end

end
