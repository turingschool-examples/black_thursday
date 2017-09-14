require './test/test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test

  attr_reader :merchant
  def setup
    @merchant = Fixture.repo(:merchants).find_by_id(2)
  end

  def test_initialize_takes_a_hash_of_fields
    assert_instance_of Merchant, merchant
  end

  def test_it_has_an_id
    assert_equal 2, merchant.id
  end

  def test_it_has_a_name
    assert_equal "merchant 2", merchant.name
  end

  def test_items_returns_an_array_of_items
    items = merchant.items
    assert_instance_of Array, items
    assert_equal 2, items.length
    assert items.all? { |item| item.is_a? Item }
  end

  def test_items_returns_items_with_own_id_as_merchant_id
    assert merchant.items.all? { |item| item.merchant_id == merchant.id }
  end

end
