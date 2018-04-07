require './test/test_helper'
require './lib/merchant'
SimpleCov.start
class MerchantTest < Minitest::Test
  def test_it_exists
    merchant = Merchant.new({:id => 5,:name => "Turing School"})
    assert_equal 5, merchant.id
    assert_equal "Turing School", merchant.name
  end
end