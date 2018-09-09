require './test/minitest_helper'
require './lib/merchant_repository'
require 'CSV'

class MerchantTest<Minitest::Test

  def test_it_exists
    mr = MerchantRepository.new('./test/fixtures/merchant_fixtures.csv')

    assert_instance_of MerchantRepository, mr
  end

  def test_merchant_repo_has_merchants
    mr = MerchantRepository.new('./test/fixtures/merchant_fixtures.csv')

    assert_equal 13 , mr.all.count
    assert_instance_of Array, mr.all
  end
end
