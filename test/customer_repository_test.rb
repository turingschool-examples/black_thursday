require_relative 'test_helper'
require_relative '../lib/customer_repository'
require_relative '../lib/sales_engine'

class CustomerRepositoryTest < Minitest::Test

  def test_customer_repo_exists
    cr = CustomerRepository.new('./data/customers.csv', self)

    assert_instance_of CustomerRepository, cr
  end

  def test_customer_repo_has_sales_engine_access
    se = SalesEngine.from_csv({
      :customers => './data/customers.csv'
      })
    cr = se.customers

    assert_instance_of SalesEngine, cr.sales_engine
  end

end
