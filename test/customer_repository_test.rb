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
    found_id_1 = customer.find_by_id(4)
    found_id_2 = customer.find_by_id(206)
    found_id_3 = customer.find_by_id(963)

    assert_equal "Leanne", found_id_1.first_name
    refute_equal "12232211", found_id_1.first_name
    assert_equal "Braun", found_id_1.last_name
    assert_equal "Oda", found_id_2.first_name
    assert_equal "Schinner", found_id_2.last_name
    assert_equal "Holly", found_id_3.first_name
    assert_equal "Trantow", found_id_3.last_name
  end

  def test_it_finds_all_by_first_name
    customer = CustomerRepository.new("./test/fixtures/customers_sample.csv", "se")
    found_id_1 = customer.find_all_by_first_name("Joey")
    found_id_2 = customer.find_all_by_first_name("Holly")
    found_id_3 = customer.find_all_by_first_name("Cecelia")

    assert_equal 2, found_id_1.count
    refute_equal -1, found_id_1.count
    assert_equal 1, found_id_2.count
    assert_equal 1, found_id_3.count
  end

  def test_it_returns_items_by_first_name
    cr = CustomerRepository.new("./test/fixtures/customers_sample.csv", "se")
    customers = cr.find_all_by_first_name("Joey")

    assert customers.all? { |customer| customer.class == Customer }
    assert_equal 2, customers.count
  end

  def test_it_finds_all_by_last_name
    customer = CustomerRepository.new("./test/fixtures/customers_sample.csv", "se")
    found_id_1 = customer.find_all_by_last_name("Ondricka")
    found_id_2 = customer.find_all_by_last_name("Nader")
    found_id_3 = customer.find_all_by_last_name("Haag")

    assert_equal 2, found_id_1.count
    assert_equal 1, found_id_2.count
    refute_equal -1, found_id_2.count
    assert_equal 1, found_id_3.count
  end

  def test_it_finds_all_invoices_by_customer_id
    se = SalesEngine.from_csv({
      invoices: "./test/fixtures/invoices_sample.csv",
      invoice_items: "./test/fixtures/invoice_items_sample.csv",
      customers: "./test/fixtures/customers_sample.csv",
      items: "./test/fixtures/items_sample.csv"
    })

    found_id_1 = se.customers.find_all_invoices_by_id(206)
    found_id_2 = se.customers.find_all_invoices_by_id(251)
    found_id_3 = se.customers.find_all_invoices_by_id(413)
    assert_equal 4, found_id_1.count
    assert_equal 1, found_id_2.count
    assert_equal 1, found_id_3.count
  end

  def test_it_returns_items_by_last_name
    cr = CustomerRepository.new("./test/fixtures/customers_sample.csv", "se")
    customers = cr.find_all_by_last_name("Toy")

    assert customers.all? { |customer| customer.class == Customer }
  end

end
