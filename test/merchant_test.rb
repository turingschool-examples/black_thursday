require './test/test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test
  def test_it_created_instance_of_merchant_class
    m = Merchant.new({:id => 5, :name => "Turing School"})
    assert_equal Merchant, m.class
  end

  def test_it_returns_the_id_of_the_merchant
    m = Merchant.new({:id => 5, :name => "Turing School"})
    assert_equal 5, m.id
  end

  def test_it_returns__the_name_of_the_merchant
    m = Merchant.new({:id => 5, :name => "Turing School"})
    assert_equal "Turing School", m.name
  end
end
