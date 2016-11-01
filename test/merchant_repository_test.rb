require 'minitest/autorun'
require 'minitest/nyan_cat'
require './lib/merchant_repository'


class MerchantRepositoryTest < Minitest::Test
  attr_reader :merchant_repository

  def setup
    @merchant_repository = MerchantRepository.new
  end

  def test_it_exists
    assert merchant_repository
  end

end
