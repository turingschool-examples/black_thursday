require_relative '../test/test_helper'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test

  def test_it_exists
    merchant = Merchant.new({id: '5', name: 'Turing School', created_at: Time.now, updated_at: Time.now})

    assert_instance_of Merchant, merchant
  end

  def test_it_has_attributes
    merchant = Merchant.new({id: '5', name: 'Turing School', created_at: Time.now, updated_at: Time.now})

    assert_equal 5, merchant.id
    assert_equal 'Turing School', merchant.name
  end

  def test_it_has_different_attributes
    merchant = Merchant.new({id: '2', name: 'East High School'})

    assert_equal 2, merchant.id
    assert_equal 'East High School', merchant.name
  end
end

def test_it_returns_created_at
  merchant = Merchant.new({id: '5', name: 'Turing School', created_at: Time.now, updated_at: Time.now})

  assert_instance_of Time, merchant.created_at
end

def test_it_returns_updated_at
  merchant = Merchant.new({id: '5', name: 'Turing School', created_at: Time.now, updated_at: Time.now})

  assert_instance_of Time, merchant.updated_at
end
