require 'minitest/autorun'
require 'minitest/nyan_cat'
require './lib/merchant.rb'
require_relative '../lib/item'


class MerchantTest < Minitest::Test
  attr_reader :merchant, :parent, :expected_items

  def setup
    @parent = Minitest::Mock.new
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
    merchant.find_items_by_merchant_id()
    parent.expect(:find_items_by_merchant_id, nil,[merchant.id])
    merchant.items
    parent.verify
  end
end
