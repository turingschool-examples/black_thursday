require './test/test_helper'
require './lib/customer'

class CustomerTest < Minitest::Test
  def setup
    @attributes = {id: 3, first_name: "John", last_name: "Madden",
                  created_at: Time.now, updated_at: Time.now}
    @customer = Customer.new(@attributes)
  end

  def test_it_exists
    assert_instance_of Customer, @customer
  end

  def test_it_has_all_attributes
    assert_equal 3, @customer.id
    assert_equal "John", @customer.first_name
    assert_equal "Madden", @customer.last_name
    assert_instance_of Time, @customer.created_at
    assert_instance_of Time, @customer.updated_at
  end

  def test_it_can_update_name
    @customer.first_name = "Jane"
    @customer.last_name = "Doe"
    assert_equal "Jane", @customer.first_name
    assert_equal "Doe", @customer.last_name
  end

end
