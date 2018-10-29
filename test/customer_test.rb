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

  def test_it_can_get_id
    assert_equal 1, @customer.id
  end

  def test_it_can_get_first_name
    assert_equal "Steve", @customer.first_name
  end

  def test_it_can_get_last_name
    assert_equal "Harness", @customer.last_name
  end

  def test_it_can_get_created_at
    assert_equal @time, @customer.created_at.to_s
  end

  def test_it_can_get_updated_at
    assert_equal @time, @customer.updated_at.to_s
  end
end
