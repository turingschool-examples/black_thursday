require './test/test_helper'
require './lib/customer'
require './lib/sales_engine'
require './lib/customer_repository'

class CustomerTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :customers => "./data/customers.csv"
      })

    @c = Customer.new({
      :id => "6",
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"
    })
  end

  def test_assert_it_exists
    assert_instance_of Customer, @c
  end

  def test_returns_iteger_id_of_customer
    assert_equal 6, @c.id
  end

  def test_returns_first_name
    assert_equal "Joan", @c.first_name
  end

  def test_returns_last_name
    assert_equal "Clarke", @c.last_name
  end

  def test_created_at_is_a_time_instance
    assert_instance_of Time, @c.created_at
  end

  def test_updated_at_is_a_time_instance
    assert_instance_of Time, @c.updated_at
  end

end
