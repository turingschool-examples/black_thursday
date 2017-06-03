require './test/test_helper'
require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'
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
    merchant = mr.find_by_name("miniaturebikez")

    assert_equal "MiniatureBikez", merchant.name
  end

  def test_to_find_by_all_by_name
    mr = MerchantRepository.new('./test/data/merchants_fixture.csv', sales_engine = nil)
    results = mr.find_all_by_name("Shop")

    assert_equal [mr.all[0]], results
  end

  def test_it_can_match_with_improper_case
    mr = MerchantRepository.new("./test/data/merchants_fixture.csv", sales_engine = nil)
    result = mr.find_by_name("SHOPIN1901")
    assert_equal "Shopin1901", result.name
  end

end
