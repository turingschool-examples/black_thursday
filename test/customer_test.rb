require_relative 'test_helper'
require_relative '../lib/customer'

class CustomerTest < Minitest::Test
  def setup
                @c = Customer.new({
              :id => 6,
              :first_name => "Joan",
              :last_name => "Clarke",
              :created_at => Time.now,
              :updated_at => Time.now
            }, self)
  end

  def test_customer_id_can_be_read
    assert_equal 6, @c.id
  end

  def test_first_name_can_be_read
    assert_equal "Joan", @c.first_name
  end

  def test_created_at_returns_time
    assert_equal Time, @c.created_at.class
  end

end
