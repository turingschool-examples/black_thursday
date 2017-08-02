require_relative 'test_helper'
require_relative '../lib/customer_repository'
require_relative '../lib/sales_engine'

class CustomerRepositoryTest < Minitest::Test

  def test_customer_repo_exists
    cr = CustomerRepository.new('./data/customers.csv', self)

    assert_instance_of CustomerRepository, cr
  end

  def test_customer_repo_has_sales_engine_access
    se = SalesEngine.from_csv({
      :customers => './data/customers.csv'
      })
    cr = se.customers

    assert_instance_of SalesEngine, cr.sales_engine
  end

  def test_customer_repo_has_file_path
    cr = CustomerRepository.new('./data/customers.csv', self)

    assert_equal './data/customers.csv', cr.file_path
  end

  def test_customer_repo_can_load_id_repo
    cr = CustomerRepository.new('./data/customers.csv', self)

    assert_instance_of Hash, cr.id_repo
    refute cr.id_repo.empty?
    assert_equal 1000, cr.id_repo.count
  end

  def test_customer_repo_can_find_all_customers
    cr = CustomerRepository.new('./data/customers.csv', self)
    customers = cr.all

    assert_instance_of Array, customers
    refute customers.empty?
    assert_instance_of Customer, customers[0]
    assert_equal 1000, customers.count
  end

  def test_customer_repo_can_find_by_id
    cr = CustomerRepository.new('./data/customers.csv', self)
    customer = cr.find_by_id(664)

    assert_instance_of Customer, customer
    assert_equal "Emelie", customer.first_name
    assert_equal "Boyle", customer.last_name
  end

  def test_customer_repo_find_by_id_returns_nil_on_bad_search
    cr = CustomerRepository.new('./data/customers.csv', self)
    customer = cr.find_by_id(99999999)

    assert_nil customer
  end

  def test_customer_repo_can_find_all_by_first_name
    cr = CustomerRepository.new('./data/customers.csv', self)
    customers = cr.find_all_by_first_name('bren')
    customers_2 = cr.find_all_by_first_name('tim')
    customers_3 = cr.find_all_by_first_name('oE')

    assert_equal 3, customers.count
    assert_equal 2, customers_2.count
    assert_equal 8, customers_3.count
  end

  def test_customer_repo_find_all_by_first_name_returns_empty_array_on_bad_search
    cr = CustomerRepository.new('./data/customers.csv', self)
    customers = cr.find_all_by_first_name('lkdjdheoeu')

    assert_equal [], customers
  end

  def test_customer_repo_can_find_all_by_last_name
    cr = CustomerRepository.new('./data/customers.csv', self)
    customers = cr.find_all_by_last_name('arm')
    customers_2 = cr.find_all_by_last_name('heL')
    customers_3 = cr.find_all_by_last_name('oE')

    assert_equal 4, customers.count
    assert_equal 11, customers_2.count
    assert_equal 14, customers_3.count
  end

  def test_customer_repo_find_all_by_last_name_returns_empty_array_on_bad_search
    cr = CustomerRepository.new('./data/customers.csv', self)
    customers = cr.find_all_by_first_name('lkdhfieylsakf')

    assert_equal [], customers
  end

  def test_customer_repo_to_se_merchants
    se = SalesEngine.from_csv({
      :merchants => './data/merchants.csv',
      :customers => './data/customers.csv',
      :invoices => './data/invoices.csv'
      })
    customers = se.customers
    merchants = customers.customer_repo_to_se_merchants(30)

    assert_instance_of Merchant, merchants[0]
    assert_equal 5, merchants.length
  end

end
