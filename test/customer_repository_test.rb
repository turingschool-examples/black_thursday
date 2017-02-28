require './test/test_helper'
require './lib/customer_repository'
require './lib/sales_engine'

class CustomerRepositoryTest < Minitest::Test
  include SalesEngineTestSetup

  def setup
    super
  end


  def test_it_exists
    assert_instance_of CustomerRepository, @se.customers
  end

end
