require_relative 'test_helper'
require_relative "../lib/customer_repository"

class CustomerRepositoryTest < Minitest::Test

  def test_it_exists
    customer = CustomerRepository.new("./test/fixtures/customers_sample.csv", "se")

    assert_instance_of CustomerRepository, customer
  end

  def test_customers_is_filled
    customer = CustomerRepository.new("./test/fixtures/customers_sample.csv", "se")

    assert_instance_of Customer, customer.customers.first
    assert_instance_of Customer, customer.customers.last
  end

  def test_it_returns_correct_id
    customer = CustomerRepository.new("./test/fixtures/customers_sample.csv", "se")
    found_id = customer.find_by_id(4)

    assert_equal "Leanne", found_id.first_name
    assert_equal "Braun", found_id.last_name
  end

  def test_it_finds_all_by_first_name
    customer = CustomerRepository.new("./test/fixtures/customers_sample.csv", "se")
    found_id = customer.find_all_by_first_name("Joey")

    assert_equal 2, found_id.count
  end

  def test_it_returns_items_by_first_name
    cr = CustomerRepository.new("./test/fixtures/customers_sample.csv", "se")
    customers = cr.find_all_by_first_name("Joey")

    assert customers.all? { |customer| customer.class == Customer }
    assert_equal 2, customers.count
  end

  def test_it_finds_all_by_last_name
    customer = CustomerRepository.new("./test/fixtures/customers_sample.csv", "se")
    found_id = customer.find_all_by_last_name("Ondricka")

    assert_equal 2, found_id.count
  end

###

  def test_it_finds_all_invoices_by_customer_id
    se = SalesEngine.from_csv({
      invoices: "./test/fixtures/invoices_sample.csv",
      invoice_items: "./test/fixtures/invoice_items_sample.csv",
      customers: "./test/fixtures/customers_sample.csv",
      items: "./test/fixtures/items_sample.csv"
    })
    
    found_id = se.customers.find_all_invoices_by_id(206)
    assert_equal 4, found_id.count
  end

  def test_it_returns_items_by_last_name
    cr = CustomerRepository.new("./test/fixtures/customers_sample.csv", "se")
    customers = cr.find_all_by_last_name("Toy")

    assert customers.all? { |customer| customer.class == Customer }
  end

end
