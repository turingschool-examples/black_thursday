require './test/test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test
  def test_inputs_are_name_and_id
    m = Merchant.new({:id => 314151, :name => "Turing School"})
    assert_equal 314151, m.id
    binding.pry
    assert_equal "Turing School", m.name
  end

end
