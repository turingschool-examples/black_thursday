require './lib/merchant'
require 'pry'
require 'minitest/autorun'
require 'minitest/emoji'

class MerchantTest < Minitest::Test

  def setup
    @merchant = Merchant.new({id: 1, name: "Bob's Bagpipes"})
  end

  def test_merchant_exists
    assert_instance_of Merchant, @merchant
  end

  def test_has_id
    assert_equal 1, @merchant.id
  end

  def test_merchant_has_name
    assert_equal "Bob's Bagpipes", @merchant.name
  end


end
