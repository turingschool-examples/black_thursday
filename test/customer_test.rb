require './test/test_helper'

class CustomerTest < Minitest::Test
  attr_reader :customer

  def setup
    @customer = Customer.new({
      :id         => 6,
      :first_name => "Joan",
      :last_name  => "Clarke",
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"},
      parent = ""
    )
  end

  def test_it_exists
    assert_instance_of Customer, customer
  end

  def test_it_has_id
    assert_equal 6, customer.id
  end

  def test_it_has_names
    assert_equal "Joan", customer.first_name
    assert_equal "Clarke", customer.last_name
  end

  def test_it_creates_at_time
    assert_instance_of Time, customer.created_at
  end

  def test_it_updates_at_time
    assert_instance_of Time, customer.updated_at
  end

end
