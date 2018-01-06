require_relative 'test_helper'
require_relative "../lib/merchant_repository"
require_relative "../lib/sales_engine"

class MerchantRepositoryTest < Minitest::Test

  attr_reader :merchant

  def setup
    @merchant = MerchantRepository.new("./test/fixtures/merchants_sample.csv", "se")
  end

  def test_it_exists
    assert_instance_of MerchantRepository, merchant
  end

  def test_Merchants_is_filled
    assert_instance_of Merchant, merchant.merchants.first
    assert_instance_of Merchant, merchant.merchants.last
  end

  def test_it_returns_matches_by_id
    found_id = merchant.find_by_id(12334185)

    assert_equal "Madewithgitterxx", found_id.name
  end

  def test_it_returns_matches_by_name
    found_name = merchant.find_by_name("FlavienCouche")

    assert_equal 12334195, found_name.id
    refute_equal "123223", found_name.id
  end

  def test_it_returns_matches_for_all_by_name
    found_names = merchant.find_all_by_name("an")

    assert_equal 1, found_names.count
    assert_includes found_names.first.name.downcase, "an"
  end

  def test_it_returns_items_for_a_merchant
    se = SalesEngine.from_csv({
    :items     => "./test/fixtures/items_sample.csv",
    :merchants => "./test/fixtures/merchants_sample.csv",
  })
    merchants = se.merchants
    merchant_id = 12334185
    found_id = merchants.find_item(merchant_id)

    assert_equal 3, found_id.count
  end

  def test_it_returns_total_merchants
    expected = merchant.merchants.count

    assert_equal expected, merchant.all.count
  end



end
