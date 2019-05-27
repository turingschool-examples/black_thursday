require_relative 'test_helper'
require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test
  def setup
    @invoices = mock('invoicerepository')
    @cr = CustomerRepository.new(@invoices)
    @cr.from_csv('./test/fixtures/customers_truncated.csv')
  end

  def test_all_returns_all_known_customers
    customers = @cr.all

    all_customers = customers.all? do |customer|
      customer.class == Customer
    end

    assert_equal 6, customers.length
    assert all_customers
  end

  def test_it_can_find_a_customer_by_id
    customer = @cr.find_by_id(1)

    assert_equal 1, customer.id
    assert_instance_of Customer, customer
  end

  def test__find_by_id_returns_nil_if_no_customer_has_id
    assert_nil @cr.find_by_id(22)
  end

  def test_find_all_by_first_name_finds_all_customers_with_given_fragment_in_first_name
    fragment = "ann"
    customers = @cr.find_all_by_first_name(fragment)

    all_match_fragment = customers.all? do |customer|
      customer.first_name.include?(fragment.downcase)
    end

    assert_equal 2, customers.length
    assert all_match_fragment
  end

  def test_find_all_by_first_name_returns_empty_array_when_no_customers_name_matches_given_fragment
    first_name = "Lou"
    customers = @cr.find_all_by_first_name(first_name)

    assert customers.empty?
  end

  def test_find_all_by_last_name_finds_all_customers_with_given_fragment_in_last_name
    fragment = "ond"
    customers = @cr.find_all_by_last_name(fragment)

    all_have_name = customers.all? do |customer|
      customer.last_name.downcase.include?(fragment.downcase)
    end

    assert_equal 2, customers.length
    assert all_have_name
  end

  def test_find_all_by_last_name_returns_empty_array_when_no_customers_name_matches_given_fragment
    last_name = "Johns"
    customers = @cr.find_all_by_last_name(last_name)

    assert customers.empty?
  end

  def test_it_calls_its_parent_to_find_invoices_by_customer_id
    invoice = mock('invoice')
    @invoices.expects(:find_invoices_by_customer_id).returns([invoice, invoice])

    assert_equal [invoice, invoice], @cr.find_invoices_by_customer_id(3)
  end
end
