require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/invoice_repo'
require './lib/invoice'
require './lib/sales_engine'
require './lib/merchant'
require './lib/merchant_repo'
require './lib/item'
require './lib/item_repo'
require './lib/transaction'
require './lib/transaction_repo'
require './lib/customer'
require './lib/customer_repo'


class CustomerRepoTest < MiniTest::Test

  def setup
    @se = SalesEngine.from_csv({
                              :customers => "./data/customers.csv"
                              })
    @customer = @se.customers
  end

  def test_it_exists
    assert_instance_of CustomerRepo, @customer
  end

  def test_customer_repo_can_find_all
    expected = @se.customers.all
    assert_equal 1000, expected.count
  end

  def test_customer_repo_can_find_by_id
    expected = @customer.find_by_id(100)
    expect_nil = @customer.find_by_id(000)

    assert_equal 100, expected.id
    assert_equal Customer, expected.class
    assert_nil expect_nil
  end

  def test_customer_repo_can_find_by_first_name
    expected = @customer.find_all_by_first_name("oe")
    expect_nil = @customer.find_all_by_first_name("000")

    assert_equal 8, expected.length
    assert_equal Customer, expected.first.class
    assert_equal [], expect_nil
  end

  def test_customer_repo_can_find_by_last_name
    expected = @customer.find_all_by_last_name("On")
    expect_nil = @customer.find_all_by_last_name("000")

    assert_equal 85, expected.length
    assert_equal Customer, expected.first.class
    assert_equal [], expect_nil
  end

  def test_create_attributes
  attributes = {
                :first_name => "Joan",
                :last_name => "Clarke",
                :created_at => Time.now,
                :updated_at => Time.now
              }
  @se.customers.create(attributes)
  expected = @se.customers.find_by_id(1001)
  assert_equal "Joan", expected.first_name
  end

  def test_update_customer_attributes
    attributes = {
      last_name: "Smith"
    }
    @se.customers.update(100, attributes)
    expected = @se.customers.find_by_id(100)
    assert_equal "Smith", expected.last_name
    assert_equal "Genoveva", expected.first_name
  end

  def test_customer_can_be_deleted
    @se.customers.delete(1001)
    expected = @se.customers.find_by_id(1001)
    assert_nil expected
  end
end
