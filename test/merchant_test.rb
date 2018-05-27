require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/merchantrepository'
require_relative '../lib/merchant'
require 'csv'
class MerchantTest < Minitest::Test
  def test_it_exists
    m = Merchant.new({:id => 5, :name => "Turing School"})
    assert_instance_of Merchant, m
  end
end
