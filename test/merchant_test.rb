require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def test_that_merchant_stores_id_and_name
    m = Merchant.new({:id => 1,:name => "Bob"})
    assert_equal 1, m.id
    assert_equal "Bob", m.name
  end

  def test

  end


end