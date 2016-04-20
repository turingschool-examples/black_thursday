require "minitest/autorun"
require "./lib/merchant"
require "csv"

class MerchantTest < Minitest::Test

  def test_it_exists
    merch = Merchant.new({:id => 5, :name => "Turing School"})
    assert merch
  end

  def test_has_name
    merch = Merchant.new({:id => 5, :name => "Turing School"})
    assert_equal "Turing School", merch.name
  end

  def test_it_has_id
    merch = Merchant.new({:id => 5, :name => "Turing School"})
    assert_equal 5, merch.id
  end

end
