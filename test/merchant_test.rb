require_relative "test_helper"
require_relative "../lib/merchant"

class MerchantTest < Minitest::Test

  def test_it_exists
    parent = mock("parent")
    merchant = Merchant.new({id: 1, name: "monkey", created_at: "2009-05-30"}, parent)

    assert_instance_of Merchant, merchant
  end

  def test_it_has_id
    parent = mock("parent")
    merchant = Merchant.new({id: 1, name: "monkey", created_at: "2009-05-30"}, parent)

    assert_equal 1, merchant.id
  end

  def test_it_has_a_name
    parent = mock("parent")
    merchant = Merchant.new({id: 1, name: "monkey", created_at: "2009-05-30"}, parent)

    assert_equal "monkey", merchant.name
  end

  def test_it_has_created_at
    parent = mock("parent")
    merchant = Merchant.new({id: 1, name: "monkey", created_at: "2009-05-30"}, parent)

    assert_equal Time.parse("2009-05-30"), merchant.created_at
  end

  def test_it_has_a_parent
    parent = mock("parent")
    merchant = Merchant.new({id: 1, name: "monkey", created_at: "2009-05-30"}, parent)

    assert_equal parent, merchant.parent
  end

end
