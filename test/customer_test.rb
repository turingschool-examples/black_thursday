require_relative './test_helper'
require './lib/customer'
require 'time'
require 'bigdecimal'
require 'mocha/minitest'

class CustomerTest < Minitest::Test
  def setup
    @customer = Customer.new
  end

  def test_it_exists
    assert_instance_of Customer, @customer
  end
  #
  # def test_it_has_attributes
  #   assert_equal "filler", @customer.filler
  # end
  #
  # def test_it_can_have_different_attributes
  # end
end
