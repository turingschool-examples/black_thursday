require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < MiniTest::Test

  def test_it_exists
    mer = Merchant.new({:id => 5, :name => "Turing School"})

    assert_instance_of Merchant, mer
  end

  def test_it_has_id
    mer = Merchant.new({:id => 5, :name => "Turing School"})
    mer2 = Merchant.new({:id => 2, :name => "Turing School"})

    assert_equal 5, mer.id
    assert_equal 2, mer2.id
  end

  def test_it_has_a_name
    mer = Merchant.new({:id => 5, :name => "Turing School"})
    mer2 = Merchant.new({:id => 5, :name => "Steve"})

    assert_equal "Turing School", mer.name
    assert_equal "Steve", mer2.name
  end
end
