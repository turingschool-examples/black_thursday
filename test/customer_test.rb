require './test/test_helper'
require './lib/customer'

class CustomerTest < Minitest::Test
  def test_it_exists
    attributes = {}
    customer = Customer.new(attributes)
    assert_instance_of Customer, customer
  end

  def test_it_has_all_attributes

  end

  def test_it_can_update_name

  end


end
