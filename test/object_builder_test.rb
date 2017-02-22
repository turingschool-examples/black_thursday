require './test/test_helper'
require 'mocha/minitest'

class ObjectBuilderTest < Minitest::Test
  attr_reader :ob

  def setup
    merchant_1 = mock("merchant")
    merchant_2 = mock("merchant")
    merchant_3 = mock("merchant")

    @ob =ObjectBuilder.new

  end
  def test_build_object
    merchant_1
    merchant_2
    merchant_3

    assert_equal [merchant_1, merchant_2, merchant_3], ob.build_object("./data/merchants_test_data.csv", Merchant)
  end
end
