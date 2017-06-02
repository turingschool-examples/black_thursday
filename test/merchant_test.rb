require 'pry'

require_relative 'test_helper'
require_relative '../lib/merchant'

class MerchantTest < MiniTest::Test

  def test_if_create_class
    m = Merchant.new

    assert_instance_of Merchant, m
  end

  def test_default_attributes
    m = Merchant.new({'name'  =>  "Turing School",
                      'id'    =>  201})

    assert m.name
    assert_equal "Turing School", m.name
    assert m.id
    assert_equal 201, m.id
  end

  # def test_if_items_method_returns_items
  #   m = Merchant.new({"name"  =>  "Shopin1901",
  #                     "id"    =>  12334105})
  #
  #
  #   m.items
  #   actual = m.items.length
  #   assert_equal 1, actual
  # end


end
