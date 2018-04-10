# frozen_string_literal: true

require './test/test_helper'
SimpleCov.start
require './lib/merchant'

class MerchantTest < Minitest::Test
  def test_it_exists
    merchant = Merchant.new(id: 5, name: 'Turing School')
    assert_equal 5, merchant.id
    assert_equal 'Turing School', merchant.name
  end

  def test_it_has_id
    merchant = Merchant.new(id: 5, name: 'Turing School')
    assert_equal 5, merchant.id
  end
end
