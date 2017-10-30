require_relative 'test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test
  def test_it_exists
    merchant = Merchant.new(id: "5", name: "Turing School")

    assert_instance_of Merchant, merchant
  end

  def test_you_can_create_a_new_merchant
    merchant = Merchant.new(id: "5", name: "Turing School")

    assert_equal 5, merchant.id
    assert_equal "Turing School", merchant.name
  end
end
