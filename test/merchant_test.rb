require 'simplecov'
SimpleCov.start
require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/merchant'

class MerchantTest < Minitest::Test

  def test_it_initializes_with_hash
    merchant = Merchant.new({:id => 103383, :name => "Daniel"})
    assert_instance_of Merchant, merchant
  end

  def test_it_calls_id_as_fixnum
    merchant = Merchant.new({:id => "103383", :name => "Daniel"})
    assert_equal 103383, merchant.id
  end

  def test_it_calls_name_and_downcases_it
    merchant = Merchant.new({:id => 103383, :name => "Daniel"})
    assert_equal "daniel", merchant.name
  end

end
