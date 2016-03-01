require_relative 'test_helper'
require_relative '../lib/merchant'
require 'minitest/autorun'

class MerchantTest < Minitest::Test
  def setup
    @merchant = Merchant.new({
      :id   => 5,
      :name => "Turing School"
      })
  end

  def test_it_can_be_instantiated
    assert @merchant.instance_of?(merchant)
  end

  def test_it_can_return_its_id
    assert_equal 5, @merchant.id
  end

  def test_it_can_return_its_name
    assert_equal "Turing School", @merchant.name
  end
end
