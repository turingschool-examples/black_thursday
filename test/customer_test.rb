require_relative 'test_helper'
require_relative '../lib/customer'

class CustomerTest < Minitest::Test
  def setup
    @c = Customer.new({
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now.inspect,
      :updated_at => Time.now.inspect
    }, mock('customer_repository'))
  end

  def test_it_has_an_id
    assert_equal 6, @c.id
  end

  def test_it_has_a_first_name
    assert_equal "Joan", @c.first_name
  end

  def test_it_has_a_last_name
    assert_equal "Clarke", @c.last_name
  end

  def test_it_has_a_time_created_at
    assert_equal Time.now.inspect, @c.created_at.inspect
  end

  def test_it_has_a_time_updated_at
    assert_equal Time.now.inspect, @c.updated_at.inspect
  end
end
