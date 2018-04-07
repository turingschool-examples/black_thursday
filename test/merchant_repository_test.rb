require './lib/merchant_repository'
require 'minitest/autorun'
require 'minitest/pride'

class MerchantRepositoryTest< MiniTest::Test
  def test_it_exists
    merchant_repo = MerchantRepository.new()
    assert_instance_of MerchantRepository, merchant_repo
  end

end
