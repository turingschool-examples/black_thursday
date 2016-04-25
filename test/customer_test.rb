require_relative 'test_helper'
require_relative '../lib/customer'

class CustomerTest < Minitest::Test
  attr_reader :c, :test_data

  def setup
    @c = Customer.new({
    :id => 6,
    :first_name => "Joan",
    :last_name => "Clarke",
    :created_at => Time.new.to_s,
    :updated_at => Time.new.to_s
    })

    @test_data = ({
    :id => 6,
    :first_name => "Joan",
    :last_name => "Clarke",
    :created_at => Time.new.to_s,
    :updated_at => Time.new.to_s
    })
  end

  def test_it_created_instance_of_invoice_class
    assert_equal Customer, c.class
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

  def test_it_returns_current_time
    time = c.created_at
    current_time = Time.new
    assert_equal Time, time.class
    assert_equal current_time.year, time.year
  end

  def test_it_returns_updated_time
    time = c.updated_at
    current_time = Time.new
    assert_equal Time, time.class
    assert_equal current_time.year, time.year
  end

  def test_it_can_return_parent_when_merchants_is_called
    skip
    parent = Minitest::Mock.new
    c = Customer.new(test_data, parent)
    parent.expect(:find_merchant_by_merch_id, nil, [6])
    c.merchants
    assert parent.verify
    end
end
