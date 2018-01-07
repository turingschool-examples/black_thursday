require_relative '../test/test_helper'
require_relative '../lib/customer_repository'
#ADD UNKNOWN ITEMS TO INVOIICE_ITEM TEST
class CustomerRepositoryTest < Minitest::Test

  def test_it_exists
    cr = CustomerRepository.new

    assert_instance_of CustomerRepository, cr
  end

  def test_from_csv_creates_all_which_returns_array_of_customers
    cr = CustomerRepository.new

    cr.from_csv("./test/fixtures/customer_fixture.csv")

    cr.all.each do |customer|
      assert_instance_of Customer, customer
    end
    assert_equal 20, cr.all.count
    assert_equal 1, cr.all[0].id
    assert_equal "Joey", cr.all[0].first_name
  end

  def test_find_by_id_returns_matching_customer_or_nil
    cr = CustomerRepository.new

    cr.from_csv("./test/fixtures/customer_fixture.csv")
    customer = cr.find_by_id(18)
    unknown_customer = cr.find_by_id(13333451)

    assert_equal "Eileen", customer.first_name
    assert_equal "Gerlach", customer.last_name
    assert_nil unknown_customer
  end

  def test_find_all_by_first_name_returns_matching
    cr = CustomerRepository.new

    cr.from_csv("./test/fixtures/customer_fixture.csv")
    customers_1 = cr.find_all_by_first_name("Magnus")
    customers_2 = cr.find_all_by_first_name("ar")
    unknown_customer = cr.find_all_by_first_name("Cosmo")

    assert_equal 2, customers_1.count
    assert_equal "Sipes", customers_1[0].last_name
    assert_equal "Hoppe", customers_1[1].last_name
    assert_equal "Mariah", customers_2[0].first_name
    assert_equal "Parker", customers_2[1].first_name
    assert_equal 2, customers_2.count
    assert_equal [], unknown_customer
  end

  def test_find_all_by_last_name_returns_matching
    cr = CustomerRepository.new

    cr.from_csv("./test/fixtures/customer_fixture.csv")
    customers = cr.find_all_by_last_name("es")
    unknown_customer = cr.find_all_by_last_name("Cosmo")

    assert_equal 2, customers.count
    assert_equal "Considines", customers[0].last_name
    assert_equal "Sipes", customers[1].last_name
    assert_equal [], unknown_customer
  end

end
