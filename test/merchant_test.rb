require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < Minitest::Test
  attr_reader   :m

  def setup
    @m = Merchant.new({
      :id => 5,
      :name => "Turing School"
    })
  end

  def test_it_can_create_a_merchant
    assert m
  end

  def test_it_can_return_id
    assert_equal 5, m.id
  end

  def test_it_can_return_name
    assert_equal "Turing School", m.name
  end

end