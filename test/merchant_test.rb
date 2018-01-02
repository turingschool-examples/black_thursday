require_relative "test_helper"
require_relative "../lib/merchant"

class MerchantTest < Minitest::Test

  def test_it_exists
    merchant = Merchant.new({id: 1, name: "monkey"})

    assert_instance_of Merchant, merchant
  end

  def test_it_has_id
    merchant = Merchant.new({id: 1, name: "monkey"})

    assert_equal 1, merchant.id
  end

  def test_it_has_a_name
    merchant = Merchant.new({id: 1, name: "monkey"})

    assert_equal "monkey", merchant.name
  end

end
