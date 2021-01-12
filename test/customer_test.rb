require 'minitest/autorun'
require 'minitest/pride'
require './lib/customer_repo'
require './lib/customer'
require 'time'
require 'bigdecimal'
require './lib/sales_engine'
require './lib/sales_analyst'

class CustomerTest < Minitest::Test
  def setup
    merchant_path = './data/merchants.csv'
    item_path = './data/items.csv'
    invoice_items_path = './data/invoice_items.csv'
    customers_path = "./data/customers.csv"
    transactions_path = "./data/transactions.csv"
    invoices_path = './data/invoices.csv'
    locations = { items: item_path,
                  merchants: merchant_path,
                  invoice_items: invoice_items_path,
                  customers: customers_path,
                  transactions: transactions_path,
                  invoices: invoices_path}
    @engine = SalesEngine.new(locations)
    @customer_repo = CustomerRepository.new('./data/mock_customers.csv', @engine)
    @c = Customer.new({
                       :id => 6,
                       :first_name => "Joan",
                       :last_name => "Clarke",
                       :created_at => "#{Time.now}",
                       :updated_at => "#{Time.now}"
                       }, @customer_repo)
  end
  def test_it_exists_and_has_attributes
    assert_instance_of Customer, @c
    assert_equal 6, @c.id
    assert_equal "Joan", @c.first_name
    assert_equal "Clarke", @c.last_name
    assert_instance_of Time, @c.created_at
    assert_instance_of Time, @c.updated_at
  end
end
