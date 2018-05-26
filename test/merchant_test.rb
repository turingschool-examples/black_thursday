require_relative 'test_helper'

class MerchantTest < Minitest::Test

  MERCHANT_DATA = {id: "12334105",
                   name: "Shopin1901",
                   created_at: "2010-12-10",
                   updated_at: "2011-12-04"
                  }

  def test_it_exists
    merchant = Merchant.new(MERCHANT_DATA, MockMerchantRepository.new)

    assert_instance_of Merchant, merchant
  end

  def test_it_has_attributes
    merchant = Merhcant.new(MERCHANT_DATA, MerchantRepository.new)


  end
end
