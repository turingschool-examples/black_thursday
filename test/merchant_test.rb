require_relative 'test_helper'
require_relative '../lib/merchant'

class MerchantTest < Minitest::Test

  def setup
    data = {:id => 5, :name => "Turing School"}
    @merchant = Merchant.new(data)
  end

  def test_it_exists
    assert_instance_of Merchant, @merchant
  end

  def test_it_returns_an_id
    assert_equal 5, @merchant.id
  end

  def test_it_returns_a_different_id
    merchant = Merchant.new({:id => 23, :name => "Turing School"})

    assert_equal 23, merchant.id
  end

  def test_it_returns_a_name
    assert_equal "Turing School", @merchant.name
  end

  def test_it_returns_a_different_name
    merchant = Merchant.new({:id => 5, :name => "Yale Business School"})

    assert_equal "Yale Business School", merchant.name
  end

end
