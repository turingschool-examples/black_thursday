require_relative '../test/test_helper'
require_relative '../lib/merchant.rb'
require_relative '../lib/item'
require 'minitest/mock'


class MerchantTest < Minitest::Test
  attr_reader :merchant

  def setup
    @merchant = Merchant.new({:id => 5,
                              :name => "Turing School"})
  end

  def test_it_exists
    assert merchant
  end

  def test_it_has_id
    assert merchant.id
    assert_equal 5, merchant.id
  end

  def test_id_is_integer
    assert_equal Fixnum, merchant.id.class
  end

  def test_it_has_name
    assert merchant.name
    assert_equal "Turing School", merchant.name
  end

  def test_merchant_can_ask_mr_for_items
    skip
    parent = Minitest::Mock.new
    parent.expect(:find_items_by_merchant_id, (12334347) => ["item1", "item2"])
    merch = Merchant.new({:id => "12334347"}, parent)
    merch.items({:id => "12334347"})
    assert parent.verify
  end

end
