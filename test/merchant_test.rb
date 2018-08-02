require './test/test_helper'
require_relative '../lib/merchant'

class MerchantTest < MiniTest::Test
  def setup
    @merchant = Merchant.new(
      {
        :id => 5,
        :name => "Turing School",
        :created_at => "2010-12-10",
        :updated_at => "2011-12-04"
        }
      )
  end

  def test_it_exists
    assert_instance_of Merchant, @merchant
  end

  def test_it_has_attributes
    assert_equal 5, @merchant.id
    assert_equal "Turing School", @merchant.name
    assert_instance_of Time, @merchant.created_at
    assert_instance_of Time, @merchant.updated_at
  end
end
