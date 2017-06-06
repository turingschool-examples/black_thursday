require_relative 'test_helper'
require_relative '../lib/customer'
require_relative '../lib/sales_engine'

class CustomerTest < MiniTest::Test

  def setup
      @c = Customer.new({"id"          => '1',
                         "first_name"  => 'Joan',
                         "last_name"   => "Clarke",
                         "created_at"  => '1993-09-29 11:56:40 UTC',
                         "updated_at"  => '1993-09-29 11:56:40 UTC'
                        })
      @files = {:items => './test/data/test_items_3.csv',
                :merchants => './test/data/merchants_test_3.csv',
                :invoices => './test/data/invoices_test.csv',
                :invoice_items => './test/data/invoice_items_test.csv',
                :transactions  => './test/data/transactions_test.csv',
                :customers     => './test/data/customers_test.csv'}
  end

  def test_if_class_creates

    assert_instance_of Customer, @c
  end

  def test_default_attributes_and_format

    assert_equal 1, @c.id
    assert_equal "Joan", @c.first_name
    assert_equal "Clarke", @c.last_name
    assert @c.created_at
    assert @c.updated_at
  end

  def test_merchants_returns_array_of_merchants
    se = SalesEngine.from_csv(@files)
    customer = se.customers.find_by_id(2)
    actual = customer.merchants
    expected = [se.merchants.all[3]]

    assert_equal expected, actual
  end
end
