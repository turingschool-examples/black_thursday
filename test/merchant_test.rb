require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def test_it_exist
    merchant = Merchant.new({:id => 5, :name => "Turing School"})

    assert_instance_of Merchant, merchant
  end

  def test_it_has_an_id
    merchant = Merchant.new({:id => 5, :name => "Turing School"})

    assert_equal 5, merchant.id
  end

  def test_it_has_a_name
    merchant = Merchant.new({:id => 5, :name => "Turing School"})

    assert_equal "Turing School", merchant.name
  end


end
