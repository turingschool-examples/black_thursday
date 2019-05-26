require_relative 'test_helper'
require 'time'
require_relative "../lib/customer"


class CustomerTest < Minitest::Test

  def setup
    @customer = Customer.new({
      :id           => "1",
      :first_name   => "Joey",
      :last_name    => "Ondricka",
      :created_at   => "2018-01-02 14:37:20 -0700",
      :updated_at   => "2018-01-02 14:37:25 -0700"
    })
  end

  def test_it_exists
    assert_instance_of Customer, @customer
  end

  def test_it_has_first_name
    assert_equal "Joey", @customer.first_name
  end

  def test_it_has_last_name
    assert_equal "Ondricka", @customer.last_name
  end

  def test_it_has_an_id
    assert_equal 1, @customer.id
  end

  def test_it_creates_at_a_time
    assert_equal Time.parse("2018-01-02 14:37:20 -0700"), @customer.created_at
  end

  def test_it_returns_time_updated_at
    assert_equal Time.parse("2018-01-02 14:37:25 -0700"), @customer.updated_at
  end

end
