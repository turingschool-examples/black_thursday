require_relative 'test_helper'
require_relative '../lib/customer'

class CustomerTest < Minitest::Test
  attr_reader :c

  def setup
    @c = Customer.new({:id => 6,
                       :first_name => "Joan",
                       :last_name => "Clarke",
                       :created_at => Time.now,
                       :updated_at => Time.now
                      })

  end

  def test_it_exists
    assert_instance_of Customer, c
  end

  def test_it_returns_id
    assert_equal 6, c.id
  end

  def test_it_returns_first_name
    assert_equal "Joan", c.first_name
  end

  def test_it_returns_last_name
    assert_equal "Clarke", c.last_name
  end

  def test_it_knows_created_at_date
    assert_instance_of Time, c.created_at
  end

  def test_it_knows_updated_date
    assert_instance_of Time, c.updated_at
  end

end
