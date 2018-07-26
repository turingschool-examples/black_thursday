require 'minitest/autorun'
require 'minitest/pride'
require_relative'./merchant'
class MerchantTest < MiniTest::Test

  def test_merchant_exists
    m = Merchant.new({:id => 5, :name => "Turing School"})
    assert_instance_of Merchant , m
  end

  def test_merchant_has_attributes
    m = Merchant.new({:id => 5, :name => "Turing School"})
    assert_equal({:id => 5, :name => "Turing School"}, m.attributes_hash)
    assert_equal 5 , m.id
    assert_equal "Turing School" , m.name
  end
end
