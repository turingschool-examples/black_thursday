require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'
require 'csv'

class MerchantTest < Minitest::Test
  def test_it_exists_and_has_attributes
    m = Merchant.new({ id: 5, name: 'Turing School' })

    assert_instance_of Merchant, m
    assert_equal 5, m.id
    assert_equal 'Turing School', m.name
  end
end
