require './test/test_helper'
require_relative '../lib/customer.rb'

class CustomerTest < Minitest::Test
  def setup
    @c = Customer.new({
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now,
      :updated_at => Time.now
      } )
  end

  def test_it_exists
    assert_instance_of Customer, @c
  end

  def test_it_has_attributes
    assert_equal 6, @c.id
    assert_equal "Joan", @c.first_name
    assert_equal "Clarke", @c.last_name
    assert_instance_of Time, @c.created_at
    assert_instance_of Time, @c.updated_at
  end
end
