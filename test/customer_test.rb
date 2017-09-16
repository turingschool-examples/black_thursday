require_relative 'test_helper'
require_relative '../lib/customer'
require_relative '../lib/sales_engine'

class CustomerTest < Minitest::Test

  def setup
    se = SalesEngine.from_csv({:customers => "./test/fixtures/customers_fixture.csv"})

    cr = se.customers
  end

  def test_customer_exists
    cr = setup
    assert_instance_of Customer, cr.customers[0]
  end

  def test_it_returns_customer_attributes
    cr = setup
    assert_equal 1, cr.all.first.id
    assert_equal 'Joey', cr.all.first.first_name
    assert_equal 'Ondricka', cr.all.first.last_name
    assert_instance_of Time, cr.all.first.created_at
    assert_instance_of Time, cr.all.first.updated_at
  end

end
