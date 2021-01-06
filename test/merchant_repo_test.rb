require 'minitest/autorun'
require 'minitest/pride'
require './lib/sales_engine'
require './lib/merchant_repo'
require './lib/merchant'

class MerchantRepoTest < Minitest::Test

  def test_create_instance_of_mr
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })

    mr = se.merchants
    assert_instance_of MerchantRepo, mr
  end

  def test_return_array_of_all_merchants
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })

    mr = se.merchants
    assert_equal mr.merchant_list, mr.all
  end

  def test_it_returns_nil_if_no_id_is_found
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })

    mr = se.merchants
    merchant = mr.find_by_id("000000")
    assert_nil merchant
  end

  def test_it_returns_a_merchant_id
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })

    mr = se.merchants
    expected = mr.find_by_id("12334105")
    assert_equal "12334105", expected.id
  end

  def test_it_returns_nil_if_no_name_is_found
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })

    mr = se.merchants
    merchant = mr.find_by_name("Akskakbfekh")
    assert_nil merchant
  end

  def test_it_returns_a_merchant_name
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })

    mr = se.merchants
    expected = mr.find_by_name("Shopin1901")
    assert_equal "Shopin1901", expected.name
  end
end
