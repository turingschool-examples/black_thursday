require './test/test_helper'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def test_it_exists
    merchant = Merchant.new({:id => 5, :name => "Turing School"})

    assert_instance_of Merchant, merchant
  end

  def test_it_returns_an_id
    merchant = Merchant.new({:id => 5, :name => "Turing School"})

    assert_equal 5, merchant.id
  end

  def test_it_returns_a_different_id
    merchant = Merchant.new({:id => 23, :name => "Turing School"})

    assert_equal 23, merchant.id
  end

  def test_it_returns_a_name
    merchant = Merchant.new({:id => 5, :name => "Turing School"})

    assert_equal "Turing School", merchant.name
  end

  def test_it_returns_a_different_name
    merchant = Merchant.new({:id => 5, :name => "Yale Business School"})

    assert_equal "Yale Business School", merchant.name
  end

end
