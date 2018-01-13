require_relative 'test_helper'
require 'time'
require_relative "../lib/customer"


class CustomerTest < Minitest::Test

  attr_reader :customer
  
  def setup
    customer_data = {
      :id           => "1",
      :first_name   => "Joey",
      :last_name    => "Ondricka",
      :created_at   => "2018-01-02 14:37:20 -0700",
      :updated_at   => "2018-01-02 14:37:25 -0700"}
      parent = mock('repository')
    @customer = Customer.new(customer_data, parent)
  end

  def test_it_exists
    assert_instance_of Customer, @customer
  end

  def test_it_has_attributes
    assert_equal "Joey", @customer.first_name
    assert_equal 1, @customer.id
    assert_equal Time.parse("2018-01-02 14:37:20 -0700"), @customer.created_at
    assert_equal Time.parse("2018-01-02 14:37:25 -0700"), @customer.updated_at
  end


  def test_it_returns_invoices_customer_id
    invoice_1 = mock("invoice")
    invoice_2 = mock("invoice")
    invoice_3 = mock("invoice")
    customer.customer_repo.stubs(:find_all_invoices_by_id).returns([invoice_1, invoice_2, invoice_3])

    assert_equal 3, customer.invoices.count
  end

end
