require 'simplecov'
SimpleCov.start
gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/customer'
require_relative '../lib/sales_engine'

class CustomerClassTest < Minitest::Test

  def setup
    @sales_engine = SalesEngine.from_csv({
      :items     => 'data/items.csv',
      :merchants => 'data/merchants.csv',
      :invoices => 'data/invoices.csv',
      :invoice_items => 'data/invoice_items.csv',
      :transactions => 'data/transactions.csv',
      :customers => 'data/customers.csv'
    })

    @customer1 = Customer.new(@sales_engine, {:id => "234",
      :first_name => "Joe",
      :last_name => "Blow",
      :unit_price => "13635",
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"})

    @customer2 = Customer.new(@sales_engine, {:id => "523",
      :first_name => "John",
      :last_name => "Doe",
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"})
  end

  def test_can_get_customer_id
    assert_equal 234, @customer1.id
    assert_equal 523, @customer2.id
  end

  def test_can_get_first_name_of_customer
    assert_equal "Joe", @customer1.first_name
    assert_equal "John", @customer2.first_name
  end

  def test_can_get_last_name_of_customer
    assert_equal "Blow", @customer1.last_name
    assert_equal "Doe", @customer2.last_name
  end


  def test_can_get_time_object_for_when_customer_was_created_and_updated
    assert_equal Time, @customer1.created_at.class
    assert_equal Time, @customer1.updated_at.class
  end

  def test_can_find_merchants_by_customer_id
    assert_equal [12336801, 12335971, 12335853, 12334969, 12335846, 12335072, 12334628], @customer2.merchants.map { |merchant| merchant.id }
  end

end
