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
  #
  # def test_to_find_by_all_by_name
  #   mr = MerchantRepository.new
  #   mr.add_merchants(merch_1)
  #   mr.add_merchants(merch_2)
  #   mr.add_merchants(merch_3)
  #   results = mr.find_all_by_name("Burger King")
  #
  #   assert results.include?(merch_1)
  # end

end
