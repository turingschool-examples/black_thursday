require_relative './test_helper'
require 'time'

class CustomerTest < MiniTest::Test

  def setup
    @time = Time.now.to_s
    @customer = Customer.new({
        :id => 1,
        :first_name => "Steve",
        :last_name => "Harness",
        :created_at => @time,
        :updated_at => @time,
      })
  end

  def test_it_exists
    assert_instance_of Customer, @customer
  end
end
