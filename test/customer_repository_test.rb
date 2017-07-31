require_relative 'test_helper'
require_relative '../lib/customer_repository'
require_relative '../lib/sales_engine'

class CustomerRepositoryTest < Minitest::Test

  def test_customer_repo_exists
    cr = CustomerRepository.new('./data/customers.csv', self)

    assert_instance_of CustomerRepository, cr
  end

end
