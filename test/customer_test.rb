require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer'
require 'pry'

class CustomerTest < Minitest::Test
  attr_reader :c

  def setup
    @c = Customer.new({
    :id => 6,
    :first_name => "Joan",
    :last_name => "Clarke",
    :created_at => Time.now,
    :updated_at => Time.now
    })
  end

  def test_it_exist
    assert_instance_of Customer, c
  end

  def test_it_initializes_with_id
    assert_equal 6, c.id
  end

  def test_initialize_with_first_name
    assert_equal "Joan", c.first_name
  end

  def test_initialize_with_last_name
    assert_equal "Clarke", c.last_name
  end

  def test_initialize_with_created_at_time
    assert_instance_of Time, c.created_at
  end

  def test_initialize_with_updated_at_time
    assert_instance_of Time, c.updated_at
  end

end
