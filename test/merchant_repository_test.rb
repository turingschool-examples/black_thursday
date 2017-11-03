require_relative 'test_helper'
require_relative '../lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def test_it_pulls_csv_info_from_merchants_fixture
    mr = MerchantRepository.new("./test/fixture/merchant_fixture.csv")

    assert_equal 6, mr.all.count
  end

  def test_it_returns_array_of_all_merchants
    mr = MerchantRepository.new("./data/merchants.csv")

    assert_equal 475, mr.all.count
  end

  def test_it_can_find_by_id
    mr = MerchantRepository.new("./data/merchants.csv")

    assert_instance_of Merchant, mr.find_by_id(12334155)

    merch_id = mr.find_by_id(12334174)

    assert_equal 12334174, merch_id.id
  end

  def test_it_can_find_by_name
    mr = MerchantRepository.new("./data/merchants.csv")

    merch_name = mr.find_by_name("BowlsByChris")

    assert_equal "BowlsByChris", merch_name.name
  end

  def test_it_can_find_all_by_fragment_of_name
    mr = MerchantRepository.new("./data/merchants.csv")

    merch_name = mr.find_all_by_name("style")

    assert_equal 3, merch_name.count
  end
end
