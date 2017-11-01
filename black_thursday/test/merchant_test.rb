require_relative 'test_helper'
require_relative './../lib/merchant'
require_relative './../lib/merchant_repository'
require_relative './../lib/sales_engine'

class MerchantTest < Minitest::Test
  attr_reader :repository,
              :engine

  def setup
    @engine = SalesEngine.from_csv(
      items: "./data/items.csv",
      merchants: "./data/merchants.csv"
    )

    @repository = MerchantRepository.new("./data/merchants.csv", engine)
  end

  def test_it_exists
    merchant = Merchant.new(
       {id: "5",
       name: "Turing School",
       created_at: "2010-03-30",
       updated_at: "2013-01-21"},
       repository
     )

    assert_instance_of Merchant, merchant
  end


  def test_it_can_hold_attributes
    merchant = Merchant.new(
       {id: "5",
       name: "Turing School",
       created_at: "2010-03-30",
       updated_at: "2013-01-21"},
       repository
     )

    assert_equal 5, merchant.id
    assert_equal "Turing School", merchant.name
    assert_equal Time.parse("2010-03-30"), merchant.created_at
    assert_equal Time.parse("2013-01-21"), merchant.updated_at
  end

  def test_it_has_items
    merchant = Merchant.new(
      {id: "12334185",
      name: "Turing School",
      created_at: "2010-03-30",
      updated_at: "2013-01-21"},
      repository
    )

    assert_equal 6, merchant.items.count
  end
end
