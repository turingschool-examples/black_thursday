require './test/test_helper'
require './lib/customer_repository'
require './lib/customer'

class CustomerRepositoryTest < Minitest::Test
  def setup
    @customer_1 = Customer.new({id: 3, first_name: "John", last_name: "Madden",
                  created_at: Time.now, updated_at: Time.now})
    @customer_2 = Customer.new({id: 3, first_name: "John", last_name: "Madden",
                  created_at: Time.now, updated_at: Time.now})
    @customer_3 = Customer.new({id: 3, first_name: "John", last_name: "Madden",
                  created_at: Time.now, updated_at: Time.now})
    @cr = CustomerRepository.new
    @cr.add_customer(@customer_1)
    @cr.add_customer(@customer_2)
    @cr.add_customer(@customer_3)
  end

  def test_it_exists
    assert_instance_of CustomerRepository, @cr
  end
end
