require_relative './test_helper'
require_relative '../lib/merchant'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def test_it_exists
    mr = MerchantRepository.new("./data/merchants.csv")
    assert_instance_of MerchantRepository, mr
  end

  def test_it_can_find_all_by_name
    mr = MerchantRepository.new
    m1 = Merchant.new({:id => 5, :name => "Turing School"})
    m2 = Merchant.new({:id => 1, :name => "Galvanize Schools"})
    mr << m1
    mr << m2
    assert_equal [m1, m2], mr.find_all_by_name("School")
  end

end
