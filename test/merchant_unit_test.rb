require 'minitest/autorun'
require 'minitest/pride'
require '../lib/merchant'

class MerchantTest < Minitest::Test

  def test_merchant_can_be_instantiated
    m = Merchant.new({:id => 12334105})
    assert m
    assert_equal Merchant, m.class
  end

  def test_merchant_id_can_be_identified
    m = Merchant.new({:id => 12334105})
    assert_equal 12334105, m.id
  end

  def test_merchant_name_can_be_identified
    m = Merchant.new({:id => 12334105, :name => "Turing School"})
    assert_equal "Turing School", m.name
  end

end
