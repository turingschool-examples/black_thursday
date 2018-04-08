require './test/test_helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchant_repository
  def setup
    @merchant_repository = MerchantRepository.new
  end

  def test_it_exists
  end
end
