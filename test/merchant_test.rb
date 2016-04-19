require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant.rb'

class MerchantTest < MiniTest::Test

  attr_reader :m

  def setup
    @m = Merchant.new({:id => 5, :name => "Turing School"})
  end

  def test_it_is_a_merchant_object
    assert_equal Merchant, m.class
  end

  def test_it_initializes_with_correct_id
    assert_equal 5, m.id
  end

  def test_it_initializes_with_correct_name
    assert_equal "Turing School", m.name
  end

end
