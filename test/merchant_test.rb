require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def test_it_exists
    merchant = Merchant.new({:id => 5, :name => "Turing School" })

    assert_instance_of Merchant, merchant
  end

end
