require "minitest/autorun"
require "minitest/emoji"
require "./lib/merchant"
require 'pry'
class MerchantTest < Minitest::Test

  def test_instance
    m = Merchant.new(id:"12345678", name:"Store1")

    assert_instance_of Merchant, m
  end

  def test_can_access_name_variable
    m = Merchant.new(id:"12345678", name:"Store1")

    assert_equal "Store1", m.name
  end

  def test_can_acces_id_variable
    m = Merchant.new(id:"12345678", name:"Store1")

    assert_equal "12345678", m.id
  end

end
