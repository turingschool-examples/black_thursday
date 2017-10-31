require_relative 'test_helper'
require_relative '../lib/merchant'
require 'minitest/autorun'
require 'minitest/pride'

class MerchantTest < Minitest::Test
  def test_it_exists
    merchant = Merchant.new({:id => 5, :name => "Turing School"})

    assert_instance of Merchant, merchant
  end

  def test_it_returns_correct_id
    merchant = Merchant.new({:id => 5, :name => "Turing School"})

    assert_equal 5, merchant.id
  end

  def test_it_returns_correct_name
    merchant = Merchant.new({:id => 5, :name => "Turing School"})

    assert_equal "Turing School", merchant.name
  end
end
