require_relative './helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  def test_it_exists
    mr = MerchantRepository.new('./data/merchant_mini.csv')
    assert_instance_of MerchantRepository, mr
  end
end
