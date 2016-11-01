require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'
require './lib/data_parser'

class MerchantTest < Minitest::Test
  include DataParser
  def test_merchant_class_exists
    assert_instance_of Merchant, Merchant.new({:id => 5, :name => "Turing School"})
  end

  def test_it_can_access_merchant_name_and_merchant_id
    merchant = Merchant.new({:id => 5, :name => "Turing School"})
    assert_equal "Turing School", merchant.name
    assert_equal 5, merchant.id
  end

  def test_merchant_can_parse_rows
    file = './data/merchants.csv'
    assert_instance_of Array, parse_data(file)
  end
end
