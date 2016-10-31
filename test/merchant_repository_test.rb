require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def test_it_can_create_merchant_repository
    repository = MerchantRepository.new
  end
end