require_relative './../lib/merchant_repository'
require_relative './../lib/item_repository'
require_relative '../lib/sales_engine'
require_relative 'spec_helper'
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
meta run:true
  def test_that_all_method_returns_an_array
    items_repo = ItemRepository.new([
      {id: 1, merchant_id: "122"},
      {id: 2, merchant_id: "134"},
      {id: 3, merchant_id: "345"},
      {id: 4, merchant_id: "457"},
    ])

    merchant_repo = MerchantRepository.new(
                    [
                      {id: "122", name: "11860"},
                      {id: "134", name: "10990"},
                      {id: "345", name: "10"},
                      {id: "457", name: "10"},
                    ], items_repo)

    assert_kind_of(Array, merchant_repo.all)
  end

  def test_that_the_all_method_returns_the_three_sample_merchant_stores_info
    repo = MerchantRepository.new([
        {id: 1, name: "11860"},
        {id: 2, name: "10990"},
        {id: 3, name: "10"},
        {id: 4, name: "10"},
      ])

    assert_equal 4, repo.all.count
  end

  def test_that_find_by_name_method_is_an_instance_of_merchant
    repo = MerchantRepository.new([
        {id: 1, name: "MiniatureBikez"},
        {id: 2, name: "10990"},
        {id: 3, name: "10"},
        {id: 4, name: "10"},
      ])

    assert_equal Merchant, repo.find_by_name("MiniatureBikez").class
  end

  def test_that_find_by_name_returns_a_known_merchant_name
    repo = MerchantRepository.new([
        {id: 1, name: "MiniatureBikez"},
        {id: 2, name: "10990"},
        {id: 3, name: "10"},
        {id: 4, name: "10"},
      ])

    merchant = repo.find_by_name("MiniatureBikez")

    assert_equal "MiniatureBikez", merchant.name
  end

  def test_edge_that_find_by_name_works_when_spaces_are_included
    repo = MerchantRepository.new([
        {id: 1, name: "MiniatureBikez"},
        {id: 2, name: "10990"},
        {id: 3, name: "10"},
        {id: 4, name: "10"},
      ])

    merchant = repo.find_by_name("Miniature B i kez")

    assert_equal "MiniatureBikez", merchant.name
  end

  def test_edge_that_find_by_name_works_when_not_case_sensitive
    repo = MerchantRepository.new([
        {id: 1, name: "MiniatureBikez"},
        {id: 2, name: "10990"},
        {id: 3, name: "10"},
        {id: 4, name: "10"},
      ])

    merchant = repo.find_by_name("mInIaTuRebIKez")

    assert_equal "MiniatureBikez", merchant.name
  end

  def test_edge_that_find_by_name_returns_nil_for_unknown_merchant_name
    repo = MerchantRepository.new([
        {id: 1, name: "MiniatureBikez"},
        {id: 2, name: "10990"},
        {id: 3, name: "10"},
        {id: 4, name: "10"},
      ])
    merchant = repo.find_by_name("Turing School")

    assert_equal nil, merchant
  end

  def test_that_find_by_id_returns_known_id
    repo = MerchantRepository.new([
        {id: 1, name: "MiniatureBikez"},
        {id: 2, name: "10990"},
        {id: 3, name: "10"},
        {id: 4, name: "10"},
      ])

    merchant = repo.find_by_id(4)

    assert_equal 4, merchant.id
  end

  def test_that_find_by_id_returns_nil_for_unknown_id
    repo = MerchantRepository.new([
        {id: 1, name: "MiniatureBikez"},
        {id: 2, name: "10990"},
        {id: 3, name: "10"},
        {id: 4, name: "10"},
      ])

    merchant = repo.find_by_id(000023412)

    assert_equal nil, merchant
  end

  def test_that_find_by_id_with_input_as_a_string_works
    repo = MerchantRepository.new([
        {id: 1, name: "MiniatureBikez"},
        {id: 2, name: "10990"},
        {id: 3, name: "10"},
        {id: 10, name: "10"},
      ])

    merchant = repo.find_by_id("10")

    assert_equal 10, merchant.id
  end

  def test_edge_that_even_when_searching_for_correct_id_with_spaces_it_will_still_return
    repo = MerchantRepository.new([
        {id: 1000, name: "MiniatureBikez"},
        {id: 2000, name: "10990"},
        {id: 3000, name: "10"},
        {id: 4000, name: "10"},
      ])

    merchant = repo.find_by_id("4 0 0 0 ")

    assert_equal 4000, merchant.id
  end

  def test_that_find_all_by_name_returns_known_merchant_with_fragment_input
    skip
    se = SalesEngine.from_csv({
                              :merchants => "./data/merchant_sample.csv",
                              })
    mr       = se.merchants
    merchant = mr.find_all_by_name("Mini")

    assert_equal ["MiniatureBikez","Shopinmini", "heyMiniWheels", "MiniatureTights"], merchant
  end

  def test_that_find_all_by_name_returns_nil_for_unknown_merchant_with_fragment_input
    skip
    se = SalesEngine.from_csv({
                              :merchants => "./data/merchant_sample.csv",
                              })
    mr       = se.merchants
    merchant = mr.find_all_by_name("turing")

    assert_equal [], merchant
  end

end
