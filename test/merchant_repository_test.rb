require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def test_it_exists
    mr = MerchantRepository.new

    assert_instance_of MerchantRepository, mr
  end

  def test_it_returns_all_merchants
    skip
    mr = MerchantRepository.new
    merchant_1 = Merchant.new({:id => 5, :name => "Turing School"})
    merchant_2 = Merchant.new({:id => 7, :name => "G School"})
    merchant_3 = Merchant.new({:id => 9, :name => "Denver University"})

    expected = [merchant_1, merchant_2, merchant_3]
    actual = mr.all

    assert_equal expected, actual
  end

end
