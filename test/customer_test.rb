require_relative 'test_helper'
require_relative '../lib/customer'

# test for customer class
class CustomerTest < Minitest::Test
  def setup
    @customer = Customer.new(id: 6,
                             first_name: 'Joan',
                             last_name: 'Clarke',
                             created_at: Time.now,
                             updated_at: Time.now)
  end

  def test_class_can_be_instantiated
    assert_instance_of Customer, @customer
  end

  def test_class_has_attributes
    assert_equal 6,          @customer.id
    assert_equal 'Joan',     @customer.first_name
    assert_equal 'Clarke',   @customer.last_name
    assert_instance_of Time, @customer.created_at
    assert_instance_of Time, @customer.updated_at
  end

  def test_invoices_method
    parent = mock
    parent.stubs(:pass_customer_id_to_se).returns([])
    customer = Customer.new({ id: 6,
                              first_name: 'Joan',
                              last_name: 'Clarke',
                              created_at: Time.now,
                              updated_at: Time.now }, parent)

    assert_equal customer.invoices, parent.pass_customer_id_to_se
  end
end
