require_relative '../lib/sales_engine'
require 'bigdecimal'
require 'time'
require_relative '../lib/customer'
require 'csv'
require 'minitest/autorun'
require 'minitest/emoji'

class CustomerTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
              :items => "./test/data/items_fixture.csv",
              :merchants => "./test/data/merchants_fixture.csv",
              :invoice_items => "./test/data/invoice_items_fixture.csv",
              :invoices => "./test/data/invoices_fixture.csv",
              :transactions => "./test/data/transactions_fixture.csv",
              :customers => "./test/data/customers_fixture.csv"
            })
    @c = Customer.new({
              :id => 6,
              :first_name => "Joan",
              :last_name => "Clarke",
              :created_at => Time.now,
              :updated_at => Time.now
            }, @se.customers)
    end

    def test_it_exists
      assert_instance_of Customer, @c
    end

    def test_has_attributes
      assert_equal 6, @c.id
      assert_equal "Joan", @c.first_name
      assert_equal "Clarke", @c.last_name
      assert_instance_of Time, @c.created_at
      assert_instance_of Time, @c.updated_at
    end

    def test_merchants_returns_array_of_merchants
      customer = @se.customers.find_by_id(1)
      assert_equal 8, customer.merchants.count
      assert_instance_of Merchant, customer.merchants
    end
end
