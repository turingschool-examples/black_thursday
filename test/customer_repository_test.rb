require_relative '../lib/customer_repository'
require 'minitest/autorun'
require 'minitest/emoji'
require_relative '../lib/sales_engine'
require 'csv'
require 'bigdecimal'

class CustomerRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv({
              :items => "./test/data/items_fixture.csv",
              :merchants => "./test/data/merchants_fixture.csv",
              :invoice_items => "./test/data/invoice_items_fixture.csv",
              :invoices => "./test/data/invoices_fixture.csv",
              :transactions => "./test/data/transactions_fixture.csv",
              :customers => "./test/data/customers_fixture.csv"
            })
    @c = @se.customers
  end

  def test_all_returns_array_of_all_customers
    assert_instance_of Array, @c.all
    assert_equal 50, @c.all.count
  end

  def find_by_id
    assert_instance_of Customer, @c.find_by_id(6)
  end

  def test_find_all_by_first_name
    assert_instance_of Array, @c.find_all_by_first_name("Mariah")
    assert_equal 1, @c.find_all_by_first_name("Mariah").count
  end

  def test_find_all_by_last_name
    assert_instance_of Array, @c.find_all_by_last_name("Ondricka")
    assert_equal 1, @c.find_all_by_last_name("Ondricka").count
  end

end
