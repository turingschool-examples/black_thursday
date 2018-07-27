require_relative 'test_helper'
require_relative '../lib/customer.rb'


class CustomerTest < Minitest::Test

  def setup
    @customer = Customer.new({
      id: 6,
      first_name: "Joan",
      last_name: "Clarke",
      created_at: "1972-07-30 18:08:53 UTC",
      updated_at: "2016-01-11 18:30:35 UTC"
      })
  end

  def test_it_exists
    assert_instance_of Customer, @customer
  end

  def test_it_has_a_id
    assert_equal 6, @customer.id
  end

  def test_it_has_a_first_name
    assert_equal "Joan", @customer.first_name
  end

  def test_it_has_a_last_name
    assert_equal "Clarke", @customer.last_name
  end

  def test_it_has_a_created_time
    assert_equal Time.parse("1972-07-30 18:08:53 UTC"), @customer.created_at
  end

  def test_it_has_a_updated_time
    assert_equal Time.parse("2016-01-11 18:30:35 UTC"), @customer.updated_at
  end
end
