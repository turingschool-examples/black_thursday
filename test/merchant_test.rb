require_relative 'test_helper'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test

  def test_merchant_exists
    assert Merchant.new({})
  end

  def test_merchant_knows_id
    merchant = Merchant.new({:id => 5, :name => "Turing School"})
    assert_equal 5, merchant.id
  end

  def test_merchant_knows_a_differentid
    merchant = Merchant.new({:id => 3, :name => "Turing School"})
    assert_equal 3, merchant.id
  end

  def test_merchant_knows_name
    merchant = Merchant.new({:id => 5, :name => "Turing School"})
    assert_equal "Turing School", merchant.name
  end

  def test_merchant_knows_a_different_name
    merchant = Merchant.new({:id => 5, :name => "Terd School"})
    assert_equal "Terd School", merchant.name
  end
  
end