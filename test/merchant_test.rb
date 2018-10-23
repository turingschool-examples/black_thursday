require "./test/test_helper"

class MerchantTest < Minitest::Test

def test_it_exists
  m = Merchant.new({:id => 5, :name => "Turing School"})
  assert_instance_of Merchant, m
end

def test_it_has_id
  m = Merchant.new({:id => 5, :name => "Turing School"})
  assert_equal 5, m.id
end



end
