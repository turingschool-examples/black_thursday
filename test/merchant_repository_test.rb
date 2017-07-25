require './lib/merchant_repository'
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'

class MerchantRepositoryTest < Minitest::Test
  def test_it_can_be_initialized
    mr = MerchantRepository.new
    assert mr
    assert_instance_of MerchantRepository, mr
  end
end
