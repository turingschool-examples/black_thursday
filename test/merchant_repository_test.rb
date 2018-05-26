require_relative 'test_helper.rb'
require './lib/sales_engine'
require 'pry'

class MerchantRepositoryTest < Minitest::Test
  def test_it_exists
    merchant = MerchantRepository.new
    assert_instance_of(MerchantRepository, merchant)
  end

  def test_it_returns_array_of_all_merchants
    skip
    se = SalesEngine.from_csv(:merchants => "./data/merchants.csv")
    mr = se.merchants
    assert_equal 450, se.merchants.all.length
  end

  def test_it_finds_merchant_by_ID
    skip
    se = SalesEngine.from_csv(:merchants => "./data/merchants.csv")
    mr = se.merchants
    # set this up so it returns the exact merchant
    assert_equal Merchant, se.merchants.find_by_id(12334159).class
    assert_nil se.merchants.find_by_id(86123876123)
  end

  def test_it_finds_by_name
    skip
    se = SalesEngine.from_csv(:merchants => "./data/merchants.csv")
    mr = se.merchants
    assert_equal Merchant, se.merchants.find_by_name("CottonBeeWraps").class
    assert_nil se.merchants.find_by_name("WhateverDude")
  end

  def test_it_finds_all_by_name
    skip
    # 12334235,WellnessNeelsen,2002-06-11,2011-12-10
    # 12336965,JewelleAccessories,2010-02-13,2011-12-29
    # search for these specific instances of these objects...
    se = SalesEngine.from_csv(:merchants => "./data/merchants.csv")
    mr = se.merchants
    assert_equal [], mr.find_all_by_name("uygg")
    assert_equal [merchant_1. merchant_2], se.merchants.find_all_by_name("well")
  end

  def test_it_can_create_merchant
    skip
    se = SalesEngine.from_csv(:merchants => "./data/merchants.csv")
    mr = se.merchants
    mr.create("FakeBusiness")
    actual = mr.find_by_name("FakeBusiness")
    assert_equal 12337412, actual.id
  end

  def test_it_can_update_name
    skip
    se = SalesEngine.from_csv(:merchants => "./data/merchants.csv")
    mr = se.merchants
    mr.update(12334105, "Newname")
    assert_equal "Newname", mr.all[0].name
  end

  def test_it_can_delete_merchant
    skip
    se = SalesEngine.from_csv(:merchants => "./data/merchants.csv")
    mr = se.merchants
    mr.delete(12334185)
    assert_nil mr.find_by_id(12334185)
  end
end
