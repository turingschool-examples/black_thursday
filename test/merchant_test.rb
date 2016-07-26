require './test/test_helper'
require './lib/sales_engine'

class MerchantTest < Minitest::Test

  def test_that_it_has_an_id
    merchant = Merchant.new({ id: "123", name: "Bill"})

    assert_equal "123", merchant.id
  end

  def test_that_it_has_a_name
    merchant = Merchant.new({ id: "123", name: "Bill"})

    assert_equal "Bill", merchant.name
  end

end
