require './test/test_helper'
require './lib/merchant'

class MerchantTest

  def test_it_has_id
    m = Merchant.new({:id => 5, :name => "Turing School"})

    assert_equal 5, m.id
  end

  def test_it_has_name
    m = Merchant.new({:id => 5, :name => "Turing School"})

    assert_equal "Turing School", m.name
  end 
end
