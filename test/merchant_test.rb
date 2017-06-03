require './tst/test_helper'
require_relative '../lib/merchant'
require 'pry'


class MerchantTest < MiniTest::Test

  def test_it_can_be_created
    assert Merchant, Merchant.new(:id => 1, :name => "Bob")
  end

  def test_it_can_call_on_id
    merchant = Merchant.new(:id => 1, :name => "Burger King")

    assert_equal 1, merchant.id
  end

  def test_it_can_call_on_name
    merchant = Merchant.new(:id => 1, :name => "Burger King")

    assert_equal "Burger King", merchant.name
  end






end
