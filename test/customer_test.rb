require_relative 'test_helper'
require_relative '../lib/customer'

class CustomerTest < MiniTest::Test

  def setup
      @c = Customer.new
  end

  def test_if_class_creates

    assert_instance_of Customer, @c
  end

end
