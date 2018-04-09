# frozen_string_literal: true

require './test/test_helper'
require_relative '../lib/merchant'

# :nodoc:
class MerchantTest < Minitest::Test
  attr_reader :merchant
  def setup
    @merchant = Merchant.new(
      id:   '5',
      name: 'Turing School'
    )
  end

  def test_it_exists
    assert_instance_of Merchant, merchant
  end

  def test_it_has_attributes
    assert_equal 5, merchant.id
    assert_equal 'Turing School', merchant.name
  end
end
