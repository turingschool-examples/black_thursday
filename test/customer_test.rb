require_relative 'test_helper'
require './lib/customer'
require 'pry'

class CustomerTest < Minitest::Test
  def setup
    @c = Customer.new({
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"
      })
  end

  def test_it_exists
    assert_instance_of Customer, @c
  end

  def test_it_has_id
    assert_equal 6, @c.id
  end

  def test_it_has_a_first_name
    assert_equal "Joan", @c.first_name
  end

  def test_it_has_a_last_name
    assert_equal "Clarke", @c.last_name
  end

  def test_it_can_take_time_created_at
    assert_instance_of Time, @c.created_at
  end

  def test_it_can_take_time_updated_at
    assert_instance_of Time, @c.updated_at
  end

end
