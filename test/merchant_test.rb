require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def test_it_has_id_and_name
    merch = Merchant.new({:id => 1234, :name => "Turing School"})
    
    assert_equal 1234, merch.id
    assert_equal "Turing School", merch.name
  end
  
end