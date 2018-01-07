require "./test/test_helper"
require "./lib/customer"

class CustomerTest < MiniTest::Test
  def setup
    @customer = Customer.new({
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now,
      :updated_at => Time.now
      })
  end

  def test_it_exists
    assert_instance_of Customer, @customer
  end

  def test_id_returns_integer_value
    assert_equal 6, @customer.id
  end

  def test_first_name_returns_string_value
    assert_equal "Joan", @customer.first_name
  end

  def test_last_name_returns_string_value
    assert_equal "Clarke", @customer.last_name
  end

  def test_created_at_returns_time_value
    assert_instance_of Time, @customer.created_at
  end

  #add time value tests

  def test_updated_at_returns_time_value
    assert_instance_of Time, @customer.updated_at
  end
end
