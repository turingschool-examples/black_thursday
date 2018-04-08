require './test/test_helper'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_merchant_repository_exists
    mr = MerchantRepository.new('./test/fixtures/merchants_truncated')
    assert_instance_of MerchantRepository, mr
  end

  def test_returns_all_instances
    mr = MerchantRepository.new('./test/fixtures/merchants_truncated')
    assert mr.merchants.empty?, mr.merchants
  end
end
