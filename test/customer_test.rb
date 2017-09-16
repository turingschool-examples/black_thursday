require_relative 'test_helper'
require_relative '../lib/customer'
require_relative '../lib/sales_engine'

class CustomerTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({:customers => "./test/fixtures/customers_fixture.csv"})
    require "pry"; binding.pry
    cr = se.customers
  end

  def test_customer_exists
    cr = setup
    assert_instance_of Customer, cr.customers[0]
  end
end
