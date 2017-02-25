require_relative 'test_helper'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test
  def test_it_exist
    m = Merchant.new({:id => 9999, :name => "Chuck"})
    assert_instance_of Merchant, m
  end

  def test_return_name
    m = Merchant.new({:id => 9999, :name => "Chuck"})
    assert_equal "Chuck", m.name
  end
  
  def test_return_id
    m = Merchant.new({:id => 9999, :name => "Chuck"})
    assert_equal 9999, m.id
  end
end