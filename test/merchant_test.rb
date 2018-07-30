# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'

require './lib/merchant'

# Merchant test class
class MerchantTest < Minitest::Test
  def setup
    @merchant = Merchant.new(
      id:         5,
      name:       'Turing School',
      created_at: '2009-05-30',
      updated_at: '2010-08-29'
    )
  end

  def test_it_exists
    assert_instance_of Merchant, @merchant
  end

  def test_it_has_attributes
    assert_equal 5, @merchant.id
    assert_equal 'Turing School', @merchant.name
    assert_instance_of Time, @merchant.created_at
    assert_instance_of Time, @merchant.updated_at
  end
end
