require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant.rb'

class MerchantTest < MiniTest::Test

  attr_reader :m

  def setup
    @m = Merchant.new({:id => "5", :name => "Turing School", :created_at => "2010-12-10"})
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

  def test_it_can_be_inspected
    assert_equal "#<Merchant", m.inspect
  end

end
