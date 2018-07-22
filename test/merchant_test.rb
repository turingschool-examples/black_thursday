require './test/test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test
  def test_it_exists
    m = Merchant.new({id: 5, name: "Turing School", created_at: '2014-06-28',
      updated_at: '2018-07-16'})
    assert_instance_of Merchant, m
  end

  def test_it_has_attributes
    m = Merchant.new({id: 5, name: "Turing School", created_at: '2014-06-28',
      updated_at: '2018-07-16'})
    assert_equal 5, m.id
    assert_equal "Turing School", m.name
    assert_equal Time.parse('2014-06-28'), m.created_at
    assert_equal Time.parse('2018-07-16'), m.updated_at
  end
end
