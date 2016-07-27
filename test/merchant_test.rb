require './test/test_helper'
require './lib/merchant'
require 'CSV'

class MerchantTest < Minitest::Test

  def test_it_creates_merchant
    data = CSV.read("./data/merchants_sample.csv", headers: true, header_converters: :symbol)

    assert_instance_of Merchant, Merchant.new(data.first)
  end

  def test_it_finds_the_merchant_id
    data = CSV.read("./data/merchants_sample.csv", headers: true, header_converters: :symbol)
    merchant = Merchant.new(data.first)

    assert_equal "12334105", merchant.id
  end

  def test_it_finds_the_merchant_name
    data = CSV.read("./data/merchants_sample.csv", headers: true, header_converters: :symbol)
    merchant = Merchant.new(data.first)

    assert_equal "Shopin1901", merchant.name
  end
end
