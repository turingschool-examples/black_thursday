require 'minitest/autorun'
require 'minitest/pride'
require 'simplecov'
require 'pry'
require '../lib/merchant.rb'

class MerchantTest < Minitest::Test

  def test_class_exists
    assert_instance_of Merchant, Merchant.new
  end

  def test_id
    m = Merchant.new({:id => 12334105, :name => "Shopin1901"})
    assert_equal 12334105, m.id 
  end

  def test_name
    m = Merchant.new({:id => 12334105, :name => "Shopin1901"})
    assert_equal "Shopin1901", m.name
  end

end
