require_relative 'test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test
  def test_merchant_class_exist
    m = Merchant.new({:id => 5, :name => "Turing School"})
    assert_instance_of Merchant, m
  end

  def test_m_can_take_a_id
    m = Merchant.new({:id => 5, :name => "Turing School"})
    assert_equal 5, m.id
  end

  def test_m_can_take_a_name
    m = Merchant.new({:id => 5, :name => "Turing School"})
    assert_equal "Turing School", m.name
  end
end
