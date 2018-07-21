require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'

class MerchantRepositoryTest < Minitest::Test

  def test_it_exists
    merchant_1 = Merchant.new({:id => 5, :name => "Turing School"})
    merchant_2 = Merchant.new({:id => 7, :name => "G School"})
    merchant_3 = Merchant.new({:id => 9, :name => "Denver University"})
    merchants = [merchant_1, merchant_2, merchant_3]
    merchant_repository = MerchantRepository.new(merchants)

    assert_instance_of MerchantRepository, merchant_repository
  end

  def test_it_returns_all_merchants
    merchant_1 = Merchant.new({:id => 5, :name => "Turing School"})
    merchant_2 = Merchant.new({:id => 7, :name => "G School"})
    merchant_3 = Merchant.new({:id => 9, :name => "Denver University"})
    merchants = [merchant_1, merchant_2, merchant_3]
    merchant_repository = MerchantRepository.new(merchants)
    
    expected = [merchant_1, merchant_2, merchant_3]
    actual = merchant_repository.all

    assert_equal expected, actual
  end

end
