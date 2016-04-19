require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant.rb'

class MerchantTest < Minitest::Test

  def test_id
    merchant_data = ["12334132","perlesemoi","2009-03-21","2014-05-19"]
    merchant = Merchant.new(merchant_data)
    assert_equal 12334132, merchant.id
  end

end
