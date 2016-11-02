require_relative 'test_helper'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test

  def setup
    merchant_repo = Minitest::Mock.new
    merchant_info1 = {:id => "5", :name => "Turing School"}
    merchant_info2 = {:id => nil, :name => nil}
    @merchant1 = Merchant.new(merchant_info1, merchant_repo)
    @merchant2 = Merchant.new(merchant_info2, merchant_repo)
  end

  def test_it_exists
    assert @merchant1
  end

  def test_it_initializes_with_parent_reference
    assert @merchant1.parent
  end

  def test_items_method_calls_parent
    @merchant1.parent.expect(:find_items_by_merchant_id, nil, [5])
    @merchant1.items
    @merchant1.parent.verify
  end

  def test_it_initializes_merchant_id
    assert_equal 5, @merchant1.id
  end

  def test_it_initializes_merchant_name
    assert_equal "Turing School", @merchant1.name
  end

  def test_it_creates_empty_string_if_merchant_info_has_no_name
    assert_equal "", @merchant2.name
  end

  def test_it_returns_zero_if_merchant_info_has_no_id
    assert_equal 0, @merchant2.id
  end

  def test_it_returns_empty_merchant_object_if_merchant_info_empty_hash
    merchant = Merchant.new({})
    assert_equal Merchant, merchant.class
    assert_nil merchant.id
    assert_nil merchant.name
  end

  def test_it_returns_empty_merchant_object_if_no_merchant_info
    merchant = Merchant.new(nil)
    assert_equal Merchant, merchant.class
    assert_nil merchant.id
    assert_nil merchant.name
  end

end
