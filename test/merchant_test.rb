require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'
require 'pry'

class MerchantTest < MiniTest::Test
  
  def test_does_it_exist
    merchant = Merchant.new({:id => 5, :name => "Turing School"})
    assert_instance_of Merchant, merchant
  end

  def test_does_it_initialize_with_id
    merchant = Merchant.new({:id => 5, :name => "Turing School"})
    assert_equal 5, merchant.id
  end

  def test_does_it_initialize_with_name
    merchant = Merchant.new({:id => 5, :name => "Turing School"})
    assert_equal "Turing School", merchant.name
  end
end
