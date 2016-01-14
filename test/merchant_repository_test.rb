require_relative './../lib/merchant_repository'
require_relative '../lib/sales_engine'
require_relative './test_helper'
require          'pry'
require          'minitest/autorun'
require          'minitest/pride'


class MerchantRepositoryTest < Minitest::Test

  def test_that_class_exist
    assert MerchantRepository
  end

  def test_that_all_method_exist
    assert MerchantRepository.method_defined? :all
  end

  def test_that_find_by_id_method_exist
    assert MerchantRepository.method_defined? :find_by_id
  end

  def test_that_find_by_name_method_exist
    assert MerchantRepository.method_defined? :find_by_name
  end

  def test_that_all_by_name_method_exist
    assert MerchantRepository.method_defined? :find_all_by_name
  end

  def test_that_all_method_returns_an_array
    se = SalesEngine.from_csv({
                              :merchants => "./data/merchant_sample.csv",
                              })
    mr = se.merchants

    assert_kind_of(Array, mr.all)
  end

  def test_that_the_all_method_returns_the_three_sample_merchant_stores_info
    se = SalesEngine.from_csv({
                              :merchants => "./data/merchant_sample.csv",
                              })
    mr = se.merchants

    assert_equal 6, mr.all.count
  end

  def test_that_find_by_name_method_is_an_instance_of_merchant
    se = SalesEngine.from_csv({
                              :merchants => "./data/merchant_sample.csv",
                              })
    mr = se.merchants
    merchant = mr.find_by_name("MiniatureBikez")

    assert_equal Merchant, merchant.class
  end

  def test_that_find_by_name_returns_a_known_merchant_name
    se = SalesEngine.from_csv({
                              :merchants => "./data/merchant_sample.csv",
                              })
    mr       = se.merchants
    merchant = mr.find_by_name("MiniatureBikez")

    assert_equal "MiniatureBikez", merchant.name
  end

  def test_edge_that_find_by_name_works_when_spaces_are_included
    se = SalesEngine.from_csv({
                              :merchants => "./data/merchant_sample.csv",
                              })
    mr       = se.merchants

    merchant = mr.find_by_name("Miniature B i kez")

    assert_equal "MiniatureBikez", merchant.name
  end

  def test_edge_that_find_by_name_works_when_not_case_sensitive
    se = SalesEngine.from_csv({
                              :merchants => "./data/merchant_sample.csv",
                              })
    mr       = se.merchants
    merchant = mr.find_by_name("mInIaTuRebIKez")

    assert_equal "MiniatureBikez", merchant.name
  end

  def test_edge_that_find_by_name_returns_nil_for_unknown_merchant_name
    se = SalesEngine.from_csv({
                              :merchants => "./data/merchant_sample.csv",
                              })
    mr       = se.merchants
    merchant = mr.find_by_name("Turing School")

    assert_equal nil, merchant
  end

  def test_that_find_by_id_returns_known_id
    se = SalesEngine.from_csv({
                              :merchants => "./data/merchant_sample.csv",
                              })
    mr = se.merchants
    merchant = mr.find_by_id(12334105)

    assert_equal "12334105", merchant.id
  end

  def test_that_find_by_id_returns_nil_for_unknown_id
    se = SalesEngine.from_csv({
                              :merchants => "./data/merchant_sample.csv",
                              })
    mr = se.merchants
    merchant = mr.find_by_id(000023412)

    assert_equal nil, merchant
  end

  def test_that_find_by_id_with_input_as_a_string_works
    se = SalesEngine.from_csv({
                              :merchants => "./data/merchant_sample.csv",
                              })
    mr = se.merchants
    merchant = mr.find_by_id("12334105")

    assert_equal "12334105", merchant.id
  end

  def test_edge_that_even_when_searching_for_correct_id_with_spaces_it_will_still_return
    se = SalesEngine.from_csv({
                              :merchants => "./data/merchant_sample.csv",
                              })
    mr = se.merchants
    merchant = mr.find_by_id("12334 105")

    assert_equal "12334105", merchant.id
  end

  def test_that_find_all_by_name_returns_known_merchant_with_fragment_input
    se = SalesEngine.from_csv({
                              :merchants => "./data/merchant_sample.csv",
                              })
    mr       = se.merchants
    binding.pry
    merchant = mr.find_all_by_name("Mini")

    assert_equal ["MiniatureBikez","Shopinmini", "heyMiniWheels", "MiniatureTights"], merchant
  end

  def test_that_find_all_by_name_returns_nil_for_unknown_merchant_with_fragment_input
    se = SalesEngine.from_csv({
                              :merchants => "./data/merchant_sample.csv",
                              })
    mr       = se.merchants
    merchant = mr.find_all_by_name("turing")

    assert_equal [], merchant
  end

end
