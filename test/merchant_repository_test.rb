require_relative '../lib/merchant_repository'
require_relative './test_helper'

class MerchantRepositoryTest < Minitest::Test
  def test_it_exist
    merchant_repository = MerchantRepository.new
    assert_instance_of MerchantRepository, merchant_repository
  end
end
