require 'simplecov'
SimpleCov.start do
  add_filter "/test/"
end
require "minitest/autorun"
require "minitest/pride"
require "./lib/merchant"
require "pry"

class MerchantTest < Minitest::Test

  def setup
    @merchant = Merchant.new({:id => 5, :name => "Turing School"})
  end

  def test_it_exists
    assert_instance_of Merchant, @merchant
  end

  def test_it_has_an_id
    assert_equal 5, @merchant.id
  end
  
  def test_it_has_a_name
    assert_equal "Turing School", @merchant.name
  end

end
