require_relative 'test_helper'
require './lib/sales_engine'
require './lib/merchant_repository'

class MerchantRepositoryTest < Minitest::Test

  def setup
    @se = SalesEngine.new({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      })
  end

  def test_it_exists

    assert_instance_of MerchantRepository, @se.merchants
  end

  def test_it_returns_an_array_of_all_merchant_instances

    assert_equal 475, @se.merchants.all.count
  end

  def test_it_finds_merchant_by_id
    merchant = @se.merchants.find_by_id(12335971)

    assert_equal 12335971, merchant.id
    assert_equal "ivegreenleaves", merchant.name
  end
end
