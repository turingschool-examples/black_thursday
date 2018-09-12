require_relative 'test_helper'

require './lib/merchant'


class MerchantTest < Minitest::Test

  def setup
    input = {:id => 5, :name => "Turing School"}
    @m = Merchant.new(input)
  end

  def test_it_exists
    assert_instance_of Merchant, @m
  end

  def test_it_has_attributes
    assert_equal 5, @m.id
    assert_equal "Turing School", @m.name
  end


end
