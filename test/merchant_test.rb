require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'
require 'pry'


class MerchantTest < MiniTest::Test

  def test_it_can_be_created
    assert Merchant, Merchant.new(5, "J")
  end

  def test_it_can_call_on_id
    merchant = Merchant.new(87654321, "Burger King")

    assert_equal 87654321, merchant.id
  end

  def test_it_can_call_on_name
    merchant = Merchant.new(87654321, "Burger King")

    assert_equal "Burger King", merchant.name
  end






end
