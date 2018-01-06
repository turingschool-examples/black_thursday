require_relative "test_helper"
require_relative "../lib/merchant"

class MerchantTest < Minitest::Test

  def test_it_exists
    parent = mock("parent")
    merchant = Merchant.new({id: 1, name: "monkey"}, parent)

    assert_instance_of Merchant, merchant
  end

  def test_it_has_id
    parent = mock("parent")
    merchant = Merchant.new({id: 1, name: "monkey"}, parent)

    assert_equal 1, merchant.id
  end

  def test_it_has_a_name
    parent = mock("parent")
    merchant = Merchant.new({id: 1, name: "monkey"}, parent)

    assert_equal "monkey", merchant.name
  end

  def test_it_has_a_parent
    parent = mock("parent")
    merchant = Merchant.new({id: 1, name: "monkey"}, parent)

    assert_equal parent, merchant.parent
  end

end
