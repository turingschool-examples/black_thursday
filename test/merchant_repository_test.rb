require './test/test_helper'
require './lib/merchant_repository'
require './lib/merchant'
require 'pry'


class MerchantRepositoryTest < MiniTest::Test

  def test_if_can_find_by_id
    mr = MerchantRepository.new('./test/data/merchants_fixture.csv', sales_engine = nil)
    id = 12334113
    merchant = mr.find_by_id(id)

    assert_equal merchant.id, id
    assert_instance_of Merchant, merchant
  end

  def test_to_find_by_name
    mr = MerchantRepository.new('./test/data/merchants_fixture.csv', sales_engine = nil)
    merchant = mr.find_by_name("MiniatureBikez")

    assert_equal "MiniatureBikez", merchant.name
  end

  def test_to_find_by_all_by_name
    mr = MerchantRepository.new('./test/data/merchants_fixture.csv', sales_engine = nil)
    merchants = mr.find_all_by_name("MiniatureBikez")

    assert_equal true, merchants.name.include?("MiniatureBikez") 
  end

end
