require_relative 'test_helper'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'

class MerchantRepositoryTest < Minitest::Test
  def setup
    files = ({:items => "./test/fixture/item_fixture.csv",
      :merchants => "./test/fixture/merchant_fixture.csv"})
    SalesEngine.from_csv(files).merchants
  end

  def test_it_pulls_csv_info_from_merchants_fixture
    assert_equal 6, setup.all.count
  end

  def test_it_returns_array_of_all_merchants
    mr = MerchantRepository.new("./data/merchants.csv", sales_engine)

    assert_equal 475, mr.all.count
  end

  def test_it_can_find_by_id
    mr = MerchantRepository.new("./data/merchants.csv", sales_engine)

    assert_instance_of Merchant, mr.find_by_id(12334155)

    merch_id = mr.find_by_id(12334174)

    assert_equal 12334174, merch_id.id
  end

  def test_it_can_find_by_name
    mr = MerchantRepository.new("./test/fixture/merchant_fixture.csv", sales_engine)

    merch_name = mr.find_by_name("Candisart")

    assert_equal "Candisart", merch_name.name
  end

  def test_it_can_find_all_by_fragment_of_name
    mr = MerchantRepository.new("./data/merchants.csv", sales_engine)

    merch_name = mr.find_all_by_name("style")

    assert_equal 3, merch_name.count
  end
end
