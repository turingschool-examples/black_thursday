require_relative "test_helper"
require_relative "../lib/merchant_repository"

class MerchantRepositoryTest < Minitest::Test

  def test_it_exists
    mr = MerchantRepository.new('./test/test_data/test_merchants.csv', "parent")

    assert_instance_of MerchantRepository, mr
  end

  def test_all_returns_array_of_merchants
    mr = MerchantRepository.new('./test/test_data/test_merchants.csv', "parent")

    assert_instance_of Array, mr.all
    mr.all.each do |merchant|
      assert_instance_of Merchant, merchant
    end
    assert_equal "Shopin1901", mr.all[0].name
    assert_equal "12334123", mr.all[4].id
  end

  def test_find_by_id_returns_appropriate_merchant
    mr = MerchantRepository.new('./test/test_data/test_merchants.csv', "parent")

    merchant = mr.find_by_id("12334123")

    assert_nil mr.find_by_id(11111111)
    assert_instance_of Merchant, merchant
    assert_equal "Keckenbauer", merchant.name
  end

  def test_find_by_name_returns_appropriate_merchant
    mr = MerchantRepository.new('./test/test_data/test_merchants.csv', "parent")

    merchant_1 = mr.find_by_name("Candisart")
    merchant_2 = mr.find_by_name("candisart")
    merchant_3 = mr.find_by_name("CANDISART")

    assert_nil mr.find_by_name("monkey")
    assert_instance_of Merchant, merchant_1
    assert_equal "12334112", merchant_1.id
    assert_instance_of Merchant, merchant_2
    assert_equal "12334112", merchant_2.id
    assert_instance_of Merchant, merchant_3
    assert_equal "12334112", merchant_3.id
  end

  def test_find_all_by_name_returns_all_names_containing_name_fragment
    mr = MerchantRepository.new('./test/test_data/test_merchants.csv', "parent")

    merchants_1 = mr.find_all_by_name("candisart")
    merchants_2 = mr.find_all_by_name("k")
    merchants_3 = mr.find_all_by_name("K")

    assert_equal [], mr.find_all_by_name("monkey")
    assert_equal "Candisart", merchants_1[0].name
    assert_equal "MiniatureBikez", merchants_2[0].name
    assert_equal "Keckenbauer", merchants_2[1].name
    assert_equal "MiniatureBikez", merchants_3[0].name
    assert_equal "Keckenbauer", merchants_3[1].name
  end

end
