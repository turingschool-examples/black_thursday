require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def test_class_exists
    result = Merchant.new#(['a', 'b'])
    assert_instance_of Merchant, result
  end


end
