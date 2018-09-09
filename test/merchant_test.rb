# require 'simplecov'
# SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/merchant'

class MerhcantTest < Minitest::Test

  def test_it_exists
    m = Merchant.new({:id => 5, :name => "Turing School"})

    assert_instance_of Merchant, m
  end

  def test_it_has_attributes
    m = Merchant.new({:id => 5, :name => "Turing School"})

    assert_equal 5, m.id
    assert_equal "Turing School", m.name
  end

end
