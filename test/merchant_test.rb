require_relative 'test_helper.rb'
require_relative '../lib/merchant.rb'

class MerchantTest < Minitest::Test 
  def test_merchant_exists 
    merchant = Merchant.new({:id => 2, 
                             :name => 'cool', 
                             :created_at => Time.now})

    assert merchant 
    assert_instance_of Merchant, merchant 
  end

  def test_merchant_returns_id 
    merchant = Merchant.new({:id => 2, 
                              :name => 'cool',
                              :created_at => Time.now})
                              
    assert_equal 2, merchant.id    
  end

  def test_merchant_returns_name 
    merchant = Merchant.new({:id => 2, 
                             :name => 'cool',
                             :created_at => Time.now})
                             
    assert_equal 'cool', merchant.name
  end
end