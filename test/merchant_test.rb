require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def setup
    @m = Merchant.new({
      :id => 4579324,
      :name => "EstyMockStore",
      :created_at => '2007-06-25',
      :updated_at => '2012-07-01'
      })
  end

  def test_it_exists
    assert_instance_of Merchant, @m
  end

  def test_it_has_attributes
    assert_equal 4579324, @m.id
    assert_equal "EstyMockStore", @m.name
    assert_equal Time.parse('2007-06-25'), @m.created_at
    assert_equal Time.parse('2012-07-01'), @m.updated_at
  end
end
