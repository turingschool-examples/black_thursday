require_relative './test_helper'
require './lib/merchant'


class MerchantTest < Minitest::Test
  def test_it_exists_and_has_attributes
    merchant = Merchant.new({:id => 5, :name => "Turing School"})
    
    assert_instance_of Merchant, merchant
    assert_equal 5, merchant.id
    assert_equal "Turing School", merchant.name
  end
end
