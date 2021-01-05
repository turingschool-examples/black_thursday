require_relative './test_helper'
require './lib/sales_engine'
class MerchantRepositoryTest < Minitest::Test
  def setup
    merchant_path = "./data/merchants.csv"
    arguments = {:merchants => merchant_path}
    @se = SalesEngine.new(arguments)
  end
  def test_it_exists
    assert_instance_of MerchantRepository, @se.merchant_repository
    assert_equal  475, @se.merchant_repository.merchants.length
  end

  def test_it_has_attributes
  end
  def test_it_can_have_different_attributes
  end
end
