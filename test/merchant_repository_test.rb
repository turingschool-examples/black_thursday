require_relative 'test_helper'
require_relative '../lib/merchant_repository.rb'

class MerchantRepositoryTest < Minitest::Test
  def setup
    merchant_repository = MerchantRepository.new
  end

  # def test_it_exists
  #   assert_instance_of MerchantRepository, merchant_repository
  # end

  def test_it_can_return_all_merchants
    merchant_1 = Merchant.new({:id => 5, :name => "Turing School"})
    merchant_2 = Merchant.new({:id => 6, :name => "Shark Tank"})

    assert_equal [merchant_1, merchant_2], merchant_repository.all
  end
end
