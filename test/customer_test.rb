require_relative 'test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer'

class CustomerTest < MiniTest::Test

  attr_reader :c

  def setup
    @c = Customer.new( {
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => "2012-12-18 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"
    })
  end

  def test_it_can_return_an_id
    assert_equal 6, c.id
  end

  def test_it_can_return_a_first_name
    assert_equal "Joan", c.first_name
  end

  def test_it_can_return_a_last_name
    assert_equal "Clarke", c.last_name
  end

  def test_it_can_return_a_time_created
    assert_equal "2012-12-18 14:54:09 UTC", c.created_at.to_s
  end

  def test_it_can_return_a_time_updated
    assert_equal "2012-03-27 14:54:09 UTC", c.updated_at.to_s
  end

  def test_it_can_be_inspected
    assert_equal "#<Customer", c.inspect
  end
end
