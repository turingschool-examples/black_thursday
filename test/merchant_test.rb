require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'
require 'pry'


class MerchantTest < MiniTest::Test

  def test_it_can_be_created
    assert_instance_of Merchant, Merchant.new({:id => 5, :name => "Turing School"})
  end

  def test_it_can_call_on_id
    merchant = Merchant.new({:id => 5, :name => "Turing School"})

    assert_equal 5, merchant.id
  end

  def test_it_can_call_on_name
    merchant = Merchant.new({:id => 5, :name => "Turing School"})

    assert_equal "Turing School", merchant.name
  end






end
