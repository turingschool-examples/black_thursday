require './test/test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test
  def test_it_exists
    m = Merchant.new(id: 5, name: 'Turing School')

    assert_instance_of Merchant, m
  end

  def test_it_has_attributes
    m = Merchant.new({ :id => 5, :name => 'Turing School' })

    assert_equal 5, m.id
    assert_equal 'Turing School', m.name
  end
  def test_it_has_different_attributes
    m = Merchant.new({ :id => 1, :name => 'Some Other School' })

    assert_equal 1, m.id
    assert_equal 'Some Other School', m.name
  end
end
