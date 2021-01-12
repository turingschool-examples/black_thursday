require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer_repo'
require './lib/sales_engine'
require './lib/sales_analyst'
require './lib/customer'
require 'time'
require 'bigdecimal'
class CustomerRepositoryTest < Minitest::Test

  def setup
    merchant_path = './data/merchants.csv'
    item_path = './data/items.csv'
    invoice_items_path = './data/invoice_items.csv'
    customers_path = "./data/customers.csv"
    transactions_path = "./data/transactions.csv"
    locations = { items: item_path,
                  merchants: merchant_path,
                  invoice_items: invoice_items_path,
                  customers: customers_path,
                  transactions: transactions_path}
    @engine = SalesEngine.new(locations)
    @customer_repo = CustomerRepository.new('./data/mock_customers.csv', @engine)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of CustomerRepository, @customer_repo
    assert_equal './data/mock_customers.csv', @customer_repo.path
    assert_instance_of SalesEngine, @customer_repo.engine
  end

  def test_it_can_return_all_customer_items
    assert_instance_of Array, @customer_repo.all
    assert_equal 30, @customer_repo.all.length
  end

  def test_find_by_id
    assert_instance_of Customer, @customer_repo.find_by_id(3)
    assert_equal "Mariah", @customer_repo.find_by_id(3).first_name
  end

  def test_find_all_by_first_name
    assert_instance_of Array, @customer_repo.find_all_by_first_name("Ramona")
    assert_equal 1, @customer_repo.find_all_by_first_name("Ramona").count
  end

  def test_find_all_by_invoice_id
    assert_instance_of Array, @customer_repo.find_all_by_last_name("Osinski")
    assert_equal 1, @customer_repo.find_all_by_last_name("Osinski").count
  end

  def test_create_creates_new_customers
    attributes = {
        :first_name => "Joan",
        :last_name => "Clarke",
        :created_at => Time.now.to_s,
        :updated_at => Time.now.to_s
      }
      @customer_repo.create(attributes)
    assert_instance_of Customer, @customer_repo.all.last
    assert_equal 31, @customer_repo.all.length
  end

  def test_update_can_update_our_customer_items
    attributes = {last_name: "Smith"}
    @customer_repo.update(3, attributes)
    assert_equal "Smith", @customer_repo.find_by_id(3).last_name
  end

  def test_delete_can_delete_customer_items
    assert_equal 3, @customer_repo.find_by_id(3).id
    @customer_repo.delete(3)
    assert_nil @customer_repo.find_by_id(3)
  end
end
