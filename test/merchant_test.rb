require './test/test_helper.rb'
require './lib/merchant.rb'
require './lib/merchant_repository.rb'
require 'pry'

class MerchantTest < Minitest::Test
  def setup
    @m = Merchant.new(
      id: 12334105,
      name: 'Shopin1901',
      created_at: '2010-12-10',
      updated_at: '2011-12-04'
    )
  end

  def test_it_exists
    assert_instance_of Merchant, @m
  end

  def test_merchant_has_attributes
    assert_equal 12334105, @m.id
    assert_equal 'Shopin1901', @m.name
    assert_equal Time.parse('2010-12-10'), @m.created_at
    assert_equal Time.parse('2011-12-04'), @m.updated_at
  end
end
