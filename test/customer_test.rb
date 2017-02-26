require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer'

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

  def test_it_gets_the_id
    assert_equal 6, c.id
  end

  def test_it_gets_first_name
    assert_equal "Joan", c.first_name
  end

  def test_it_gets_last_name
    assert_equal "Clarke", c.last_name
  end

  def test_it_gets_created_at
    assert_equal Time.now.inspect, c.created_at.inspect
  end

  def test_it_gets_updated_at
    assert_equal Time.now.inspect, c.updated_at.inspect
  end
end
