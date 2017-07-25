require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer'

class CustomerTest < Minitest::Test

  def test_it_exist
    customer = Customer.new

    assert_instance_of Customer, customer
  end

end
