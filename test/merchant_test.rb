require './test/test_helper'
require './lib/merchant'
require 'csv'

class MerchantTest < Minitest::Test
  attr_reader :merchant1,
              :merchant2,
              :merchant3
              # :merchant_row,
              # :merchant_info
  def setup
    @merchant1 = Merchant.new({ :id => "12334115", :name => "LolaMarleys" })
    @merchant2 = Merchant.new({ :id => "12334132", :name => "perlesemoi" })
    @merchant3 = Merchant.new({ :id => "12334141", :name => "jejum" })
    # @merchant_row = CSV.read("./data/merchants_sample.csv", headers: true, header_converters: :symbol)[0]
    # @merchant_info = {:id => merchant_row[:id], :name => merchant_row[:name]}
  end

  def test_it_creates_a_merchant
    assert_instance_of Merchant, merchant1
    assert_instance_of Merchant, merchant2
    assert_instance_of Merchant, merchant3
  end

  def test_it_finds_a_merchant_id
    assert_equal "12334115", merchant1.id
    assert_equal "12334132", merchant2.id
    assert_equal "12334141", merchant3.id
  end

  def test_it_finds_a_merchant_name
    assert_equal "LolaMarleys", merchant1.name
    assert_equal "perlesemoi",  merchant2.name
    assert_equal "jejum",       merchant3.name
  end
end
