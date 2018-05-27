require './lib/salesengine'
require './lib/merchantrepository'
require './lib/merchant'
require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
class MerchantTest < Minitest::Test
  def test_it_exists
    m = Merchant.new({:id => 5, :name => "Turing School"})
    assert_instance_of Merchant, m
  end
end
