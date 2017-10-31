require_relative 'test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test
  def test_it_exists
    merchant = Merchant.new(id: "5", name: "Turing School")

    assert_instance_of Merchant, merchant
  end


  def test_it_can_hold_attributes
    merchant = Merchant.new(
       id: "5",
       name: "Turing School",
       created_at: "2010-03-30",
       updated_at: "2013-01-21"
     )

    assert_equal 5, merchant.id
    assert_equal "Turing School", merchant.name
    assert_equal "2010-03-30", merchant.created_at
    assert_equal "2013-01-21", merchant.updated_at
  end
end
