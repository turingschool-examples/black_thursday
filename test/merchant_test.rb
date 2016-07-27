require './test/test_helper'
require './lib/merchant'
require 'CSV'

class MerchantTest < Minitest::Test

  def test_it_creates_merchant
    merchant_row = CSV.read("./data/merchants_sample.csv", headers: true, header_converters: :symbol)[0]
    merchant_info = {:id => merchant_row[:id], :name => merchant_row[:name]}

    assert_instance_of Merchant, Merchant.new(merchant_info)
  end

  def test_it_finds_the_merchant_id
    merchant_row = CSV.read("./data/merchants_sample.csv", headers: true, header_converters: :symbol)[0]
    merchant_info = {:id => merchant_row[:id], :name => merchant_row[:name]}
    merchant = Merchant.new(merchant_row)

    assert_equal "12334105", merchant.id
  end

  def test_it_finds_the_merchant_name
    merchant_row = CSV.read("./data/merchants_sample.csv", headers: true, header_converters: :symbol)[0]
    merchant_info = {:id => merchant_row[:id], :name => merchant_row[:name]}
    merchant = Merchant.new(merchant_row)

    assert_equal "Shopin1901", merchant.name
  end
end
