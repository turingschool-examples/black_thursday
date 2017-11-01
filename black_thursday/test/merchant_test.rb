require_relative 'test_helper'
require_relative './../lib/merchant'

class MerchantTest < Minitest::Test
  attr_reader :repository,
              :engine

  def setup
    @engine = SalesEngine.from_csv(
      items: "./test/fixtures/truncated_items.csv",
      merchants: "./test/fixtures/truncated_merchants.csv"
    )

    @repository = MerchantRepository.new("./test/fixtures/truncated_merchants.csv", engine)
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
end
