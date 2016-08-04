require './test/test_helper'
require './lib/customer_repository'
require 'csv'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :cr

  def setup
    fixture = CSV.open('./test/fixtures/customers_fixture.csv',
                          headers: true,
                          header_converters: :symbol)
    csv_rows = fixture.to_a
    @cr = CustomerRepository.new(csv_rows)
  end

  def test_method_customers_returns_array_of_customers
    assert_instance_of Array, cr.customers
    assert_equal true, cr.customers.all? { |thing| thing.class == Customer }
  end

  def test_method_all_returns_array_of_customers
    assert_equal cr.customers, cr.all
  end

  def test_method_find_by_id_returns_nil_or_customer
    customer =     cr.find_by_id(100)
    customer_nil = cr.find_by_id(9001)
    assert_instance_of Customer, customer
    assert_equal 100,          customer.id
    assert_equal nil,        customer_nil
  end

  def test_method_find_all_by_first_name_returns_array_of_customers
    customers =               cr.find_all_by_first_name("dejon")
    customers_multiple =      cr.find_all_by_first_name("ia")
    customers_empty =         cr.find_all_by_first_name("nothing here")
    assert_instance_of Array, customers
    assert_equal cr.customers[8], customers[0]
    assert_equal true,        customers_multiple.length > 1
    assert_equal [],          customers_empty
  end


  def test_method_find_all_by_last_name_returns_array_of_customers
    customers =               cr.find_all_by_last_name("OsinSki")
    customers_multiple =      cr.find_all_by_last_name("er")
    customers_empty =         cr.find_all_by_last_name("nothing here")
    assert_instance_of Array, customers
    assert_equal cr.customers[1], customers[0]
    assert_equal true,        customers_multiple.length > 1
    assert_equal [],          customers_empty
  end

  def test_method_find_all_merchants_by_id_returns_merchant
    mock_se = Minitest::Mock.new
    cr = CustomerRepository.new([], mock_se)
    mock_se.expect(:find_all_merchants_by_customer_id, nil, [200])
    cr.find_all_merchants_by_id(200)
    assert mock_se.verify
  end

  def test_method_find_fully_paid_invoices_by_customer_id_queries_parent
    mock_se = Minitest::Mock.new
    cr = CustomerRepository.new([], mock_se)
    mock_se.expect(:find_fully_paid_invoices_by_customer_id, nil, [100])
    cr.find_fully_paid_invoices_by_customer_id(100)
    assert mock_se.verify
  end

  def test_method_find_invoices_by_customer_id_queries_parent
    mock_se = Minitest::Mock.new
    cr = CustomerRepository.new([], mock_se)
    mock_se.expect(:find_all_invoices_by_customer_id, nil, [50])
    cr.find_invoices_by_customer_id(50)
    assert mock_se.verify
  end
end
