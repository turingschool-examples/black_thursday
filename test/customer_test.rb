require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer'

class CustomerTest < Minitest::Test

  def setup
    @customer = {
      :id         => 6,
      :first_name => "Joan",
      :last_name  => "Clarke",
      :created_at => Time.now,
      :updated_at => Time.now
      }
      @parent = ""
  end

  def test_it_exists
    assert_instance_of Customer, Customer.new(@customer, @parent)
  end

  def test_it_has_id
    customer = Customer.new(@customer, @parent)
    assert_equal 6, customer.id
  end

  def test_it_has_names
    customer = Customer.new(@customer, @parent)
    assert_equal "Joan", customer.first_name
    assert_equal "Clarke", customer.last_name
  end

  def test_it_creates_at_time
    customer = Customer.new(@customer, @parent)
    time = Time.now
    assert_equal time, customer.created_at
  end

  def test_it_updates_at_time
    customer = Customer.new(@customer, @parent)
    time = Time.now
    assert_equal Time, customer.updated_at
  end

end
