require './test/minitest_helper'
require './lib/merchant_repository'
require './lib/merchant'

class MerchantTest<Minitest::Test

  def test_it_exists
    mr = MerchantRepository.new("./data/merchants_mini.csv")

    assert_instance_of MerchantRepository, mr
  end

  def test_merchant_repo_has_merchants
    mr = MerchantRepository.new("./data/merchants_mini.csv")

    assert_equal 13 , mr.all.count
    assert_instance_of Array, mr.all
  end

  def test_it_can_find_merchant_by_id
    mr = MerchantRepository.new("./data/merchants_mini.csv")
    result = mr.find_by_id(12334105)

    # assert_instance_of Merchant, result
    assert_equal 12334105, result[:id]
    assert_equal "Shopin1901", result[:name]
  end

  def test_it_can_find_all_by_name
    mr = MerchantRepository.new("./data/merchants_mini.csv")

  end
end
