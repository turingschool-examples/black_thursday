require 'pry'

require 'simplecov'
SimpleCov.start
require 'bigdecimal'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'

class MerchantTest < MiniTest::Test

  def test_if_create_class
    m = Merchant.new

    assert_instance_of Merchant, m
  end

  def test_default_attributes
    m = Merchant.new({:name  =>  "Turing School",
                      :id    =>  201})
                      
    assert m.name
    assert_equal "Turing School", m.name
    assert m.id
    assert_equal 201, m.id
  end


end
