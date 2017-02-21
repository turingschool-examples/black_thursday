require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'


class MerchantTest < Minitest::Test


  def test_it_creates_an_instance_of_merchant
    m = Merchant.new({:id => 5, :name => "Turing School"})
    assert m

  end

  def test_it_can_find_an_id
    m = Merchant.new({:id => 5, :name => "Turing School"})

    assert_equal 5, m.id
  end


  def test_it_can_find_a_name
    skip
    m = Merchant.new({:id => 5, :name => "Turing School"})

    assert_equal "Turing School", m.name
  end

end
