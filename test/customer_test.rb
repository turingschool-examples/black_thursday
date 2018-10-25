require './test/test_helper'
require './lib/customer'

class CustomerTest < Minitest::Test
  def setup
    @now = Time.now
    @customer = Customer.new({
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => @now,
      :updated_at => @now
    })
  end

  def test_it_exists
    assert_instance_of Customer, @customer
  end

  def test_it_has_an_id
    assert_equal 6, @customer.id
  end

  def test_it_has_a_first_name
    assert_equal "Joan", @customer.first_name
  end

  def test_it_has_a_last_name
    assert_equal "Clarke", @customer.last_name
  end

  def test_it_has_a_created_at_time
    assert_equal @now, @customer.created_at
  end

  def test_it_has_an_updated_at_time
    assert_equal @now, @customer.updated_at
  end
end
