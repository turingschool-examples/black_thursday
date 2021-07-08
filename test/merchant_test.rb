require_relative 'test_helper'
require "./lib/merchant"

class MerchantTest < Minitest::Test

  def test_it_exist
    merchant = Merchant.new()

    assert_instance_of Merchant, merchant
  end

  def test_can_access_attributes
    merchant = Merchant.new({:id => 5,
                             :name => "Turing School",
                             :created_at => 18,
                             :updated_at => 19})

    assert_equal 5, merchant.id
    assert_equal "Turing School", merchant.name
    assert_equal 18, merchant.created_at
    assert_equal 19, merchant.updated_at
  end
end
