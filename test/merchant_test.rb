require_relative 'test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test

  MERCHANT_DATA = {id: "12334105",
                   name: "Shopin1901",
                   created_at: "2010-12-10",
                   updated_at: "2011-12-04"
                  }

  def test_it_exists
    merchant = Merchant.new(MERCHANT_DATA)
    assert_instance_of Merchant, merchant
  end

  def test_it_has_attributes
    merchant = Merchant.new(MERCHANT_DATA)

    assert_equal 12334105, merchant.id
    assert_equal "Shopin1901", merchant.name
    assert_instance_of Time, merchant.created_at
    assert_instance_of Time, merchant.updated_at
  end
end
