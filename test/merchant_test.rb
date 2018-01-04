require_relative "test_helper"
require_relative "../lib/merchant"

class MerchantTest < Minitest::Test

  def test_it_exists
    m = Merchant.new({id: 12334105, name: "Shopin1901", created_at: "2010-12-10", updated_at: "2011-12-04"}, parent = nil)

    assert_instance_of Merchant, m
  end

  def test_it_has_attributes
    m = Merchant.new({id: 12334105, name: "Shopin1901", created_at: "2010-12-10", updated_at: "2011-12-04"}, parent = nil)

    assert_equal 12334105, m.id
    assert_equal "Shopin1901", m.name
    assert_instance_of Time, m.created_at
    assert_instance_of Time, m.updated_at
    assert_nil m.parent
  end
end
