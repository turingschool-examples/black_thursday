require_relative 'test_helper'
require_relative '../lib/merchant_repository'
require_relative '../lib/sales_engine'
require 'pry'

class MerchantRepositoryTest < MiniTest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
      :items => './test/fixtures/items_fixture.csv',
      :merchants => './test/fixtures/merchants.csv',
      :invoices => './test/fixtures/invoices.csv'
      })
    @merchants = @sales_engine.merchants
  end

  def test_that_merchants_are_created
    assert_equal 12, @merchants.count
    assert_equal "Shopin1901", @merchants.merchants[0].name
    assert_equal "Candis--art", @merchants.merchants[1].name
  end

  def test_that_merchant_can_be_found_by_id
    merchant1 = @merchants.merchants[2].id


    assert_equal 12334113, @merchants.find_by_id(12334113).id
  end

  def test_that_merchant_can_be_found_by_name
    merchant1 = @merchants.merchants[0]

    assert_nil @merchants.find_by_name("Jimmy Joe Bob")
    assert_equal merchant1, @merchants.find_by_name("ShOpiN1901")
  end

  def test_that_it_can_find_all_by_name
    merchant1 = @merchants.merchants[2]
    merchant2 = @merchants.merchants[6]

    assert_equal ([]), @merchants.find_all_by_name("Jimmy Joe Bob")
    assert_equal [merchant1, merchant2], @merchants.find_all_by_name("rAy")
  end

end
