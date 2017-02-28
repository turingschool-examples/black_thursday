require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test

  def test_merchant_name
    merch = Merchant.new({:id => 22, :name => "Danny and Chris Co."}, self)
    assert_equal "Danny and Chris Co.", merch.name
  end

  def test_merchant_id
    merch = Merchant.new({:id => 22, :name => "Danny and Chris Co."}, self)
    assert_equal 22, merch.id
  end
end
