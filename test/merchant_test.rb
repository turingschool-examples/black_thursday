require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant.rb'

class MerchantTest <  Minitest::Test
  def test_it_exists
    m = Merchant.new({:id => 5, :name => "Turing School"}, self)
    assert_instance_of Merchant, m
  end

end
