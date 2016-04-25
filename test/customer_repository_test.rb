require_relative 'test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :c1, :c2

  def setup
    @c1 = Customer.new({
    :id => 6,
    :first_name => "Joan",
    :last_name => "Clarke",
    :created_at => Time.new.to_s,
    :updated_at => Time.new.to_s
    })

    @c2 = Customer.new({
    :id => 9,
    :first_name => "John",
    :last_name => "Smith",
    :created_at => Time.new.to_s,
    :updated_at => Time.new.to_s
    })

    @customers = CustomerRepository.new
    @customers.customer_repository = ([c1, c2])
    end


    def test_it_creates_a_new_instance_of_invoice_repo
      assert_equal CustomerRepository, @customers.class
    end

    def test_it_returns_an_array_of_all_customer_instances
      assert_equal 2, @customers.all.length
    end

    def test_it_can_return_a_customer_by_id
      customer = @customers.find_by_id(6)
      assert_equal "Joan", customer.first_name
    end

    def test_it_can_find_by_first_name
      customer = @customers.find_all_by_first_name("John")
      assert_equal 9, customer[0].id
    end

    def test_it_can_find_customer_by_last_name
      customer = @customers.find_all_by_last_name("Smith")
      assert_equal 9, customer[0].id
    end

    def test_it_can_return_parent_when_invoices_is_called
      skip
      parent = Minitest::Mock.new
      cr = CustomerRepository.new(c1, parent)
      parent.expect(:find_customer_by_invoice_customer_id, nil, [6])
      cr.find_invoices_by_customer_id
      assert parent.verify
    end

  end
