require_relative 'test_helper'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def setup
    se = SalesEngine.new({merchants: "./data/merchants.csv"})
    @merchant_repository = se.merchants
  end

  def test_it_exists

    assert_instance_of MerchantRepository, @merchant_repository
  end

  def test_it_returns_an_array_of_all_merchant_instances

    assert_equal 475, @merchant_repository.count
  end
end
