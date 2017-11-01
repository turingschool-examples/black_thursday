require_relative 'test_helper'
require './lib/merchant_repository'
require './lib/sales_engine'
require 'pry'

class MerchantRepositoryTest < MiniTest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({:items => './test/fixtures/items_fixture.csv', :merchants => './test/fixtures/merchants.csv'})
    @merchant_repository = @sales_engine.merchant_repository
  end

  def test_that_merchants_are_created
    assert_equal 12, @merchant_repository.count
    assert_equal "Shopin1901", @merchant_repository.merchants[0].name
    assert_equal "Candis--art", @merchant_repository.merchants[1].name
  end

  def test_that_merchant_can_be_found_by_id
    merchant1 = @merchant_repository.merchants[2]


    assert_equal merchant1, @merchant_repository.find_by_id("12334113")
  end

  def test_that_merchant_can_be_found_by_name
    merchant1 = @merchant_repository.merchants[0]

    assert_nil @merchant_repository.find_by_name("Jimmy Joe Bob")
    assert_equal merchant1, @merchant_repository.find_by_name("ShOpiN1901")
  end

  def test_that_it_can_find_all_by_name
    merchant1 = @merchant_repository.merchants[2]
    merchant2 = @merchant_repository.merchants[6]

    assert_equal ([]), @merchant_repository.find_all_by_name("Jimmy Joe Bob")
    assert_equal [merchant1, merchant2], @merchant_repository.find_all_by_name("rAy")
  end

end
