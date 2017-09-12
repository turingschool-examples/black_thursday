require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def test_it_exists
    m1 = Merchant.new({:id => 5, :name => "Turing School"})

    assert_instance_of Merchant, m1
  end

  def test_it_has_an_id
    m1 = Merchant.new({:id => 5, :name => "Turing School"})

    assert_equal 5, m1.id
  end

  def test_it_has_a_name
    m1 = Merchant.new({:id => 5, :name => "Turing School"})

    assert_equal "Turing School", m1.name
  end
end
