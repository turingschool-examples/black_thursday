require_relative 'test_helper.rb'
require './lib/sales_engine'
require './lib/merchant_repository'
require 'pry'

class MerchantTest < Minitest::Test
  def test_it_exists
    merchant = Merchant.new(information)
    assert_instance_of(Merchant, merchant)
  end

  def test_it_has_attributes
    skip
    merchant = Merchant.new(information)
  end  
end
