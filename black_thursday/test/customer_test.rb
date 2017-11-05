require_relative 'test_helper'
require 'csv'
require_relative './../lib/customer'
require_relative './../lib/customer_repository'

class CustomerTest < Minitest::Test
  attr_reader :repository

  def setup
    @engine = SalesEngine.from_csv(
      items: './test/fixtures/truncated_items.csv',
      merchants: './test/fixtures/truncated_merchants.csv',
      invoices: './test/fixtures/truncated_invoices.csv',
      transactions: './test/fixtures/truncated_transactions.csv',
      customers: './test/fixtures/truncated_customers.csv'
    )

    @repository = CustomerRepository.new("./test/fixtures/truncated_customers.csv", @engine)
  end

  def test_it_exists
    created_at = "2015-03-13"
    updated_at = "2015-04-05"

    cust = Customer.new({
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => created_at,
      :updated_at => updated_at
      })

      assert_instance_of Customer, cust
  end

  def test_it_can_hold_attributes
    created_at = "2015-03-13"
    updated_at = "2015-04-05"

    cust = Customer.new({
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => created_at,
      :updated_at => updated_at
      })

    assert_equal 6, cust.id
    assert_equal "Joan", cust.first_name
    assert_equal Time.parse(created_at), cust.created_at
  end
end