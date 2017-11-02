require_relative 'test_helper'
require 'csv'
require_relative './../lib/merchant'
require_relative './../lib/merchant_repository'

class MerchantTest < Minitest::Test
  attr_reader :repository

  def setup
    @repository = MerchantRepository.new("./test/fixtures/truncated_merchants.csv")
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
