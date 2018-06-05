# frozen_string_literal: false

require_relative 'test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test
  def setup
    @args = { id: 5, name: 'Turing School' }
    @merchant = Merchant.new(@args)
  end

  def test_it_exists
    assert_instance_of Merchant, @merchant
  end

  def test_it_has_attributes
    assert_equal 5, @merchant.id
    assert_equal 'Turing School', @merchant.name
  end
end
