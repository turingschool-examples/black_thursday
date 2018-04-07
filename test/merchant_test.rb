require './test/test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test
  def test_merchant_exists
    m = Merchant.new({:id => 5, :name => "Turing School"})
    assert_instance_of Merchant, m
  end

  def test_mechant_collects_id_and_name
    m = Merchant.new({:id => 5, :name => "Turing School"})
    assert_equal 5, m.id
  end
end
