require_relative './test_helper'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test
  def test_it_has_id_and_name
    merchant = Merchant.new({:id => 4, :name => "Turing School"})

    assert_equal 4, merchant.id
    assert_equal "Turing School", merchant.name
  end
end
