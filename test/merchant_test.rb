require './test/test_helper'
require './lib/merchant'

class Merchant_Test < Minitest::Test
  def test_exists
    m = Merchant.new({:id => 5, :name => "Turing School"})

    assert_instance_of Merchant, m
  end

  def test_has_attributes
    m = Merchant.new({:id => 5, :name => "Turing School"})

    assert_equal 5, m.id
    assert_equal "Turing School", m.name
  end
end