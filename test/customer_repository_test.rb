require_relative './test_helper'
require 'time'

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    item_path          = "./data/items.csv"
    merchant_path      = "./data/merchants.csv"
    invoice_path       = "./data/invoices.csv"
    invoice_item_path  = "./data/invoice_items.csv"
    customer_path      = "./data/customers.csv"
    arguments = {
                  :items     => item_path,
                  :merchants => merchant_path,
                  :invoices  => invoice_path,
                  :invoice_items => invoice_item_path,
                  :customers     => customer_path
                }
    @engine = SalesEngine.from_csv(arguments)
    @customers = @engine.customers
  end

  def test_all_returns_all_of_the_customers
    expected = @customers.all
    assert_equal 1000, expected.length
    assert_equal Customer, expected.first.class
  end

  def test_find_by_id_returns_the_customer_with_matching_id
    id = 100
    expected = @customers.find_by_id(id)
    assert_equal id, expected.id
    assert_equal Customer, expected.class
  end

  def test_find_all_by_first_name_returns_all_customers_with_matching_first_name
    fragment = "oe"
    expected = @customers.find_all_by_first_name(fragment)
    assert_equal 8, expected.length
    assert_equal Customer, expected.first.class
  end

  def test_find_all_by_last_name_return_all_customers_with_matching_last_name
    fragment = "On"
    expected = @customers.find_all_by_last_name(fragment)
    assert_equal 85, expected.length
    assert_equal Customer, expected.first.class
  end

  def test_find_all_by_first_name_and_find_all_by_last_name_are_case_insesntive
    skip
    fragment = "NN"
    expected = @customers.find_all_by_first_name(fragment)
    assert_equal 57, expected.length
    assert_operator Customer, expected.first.class

    fragment = "oN"
    expected = @customers.find_all_by_last_name(fragment)

    assert_equal 85, expected.length
    assert_equal Customer, expected.first.class
  end

  def test_creat_creates_a_new_customer_instance
    skip
    attributes = {
                 :first_name => "Joan",
                 :last_name => "Clarke",
                 :created_at => Time.now,
                 :updated_at => Time.now
                 }
   @customers.create(attributes)

   expected = @customers.find_by_id(1001)
   assert_equal "Joan", expected.first_name
  end

  def test_updates_updates_a_customer
    skip
    attributes = {
                 :first_name => "Joan",
                 :last_name => "Clarke",
                 :created_at => Time.now,
                 :updated_at => Time.now
                 }
    @customers.create(attributes)
    original_time = @customers.find_by_id(1001).updated_at
    attributes = {last_name: "Smith"}
    @customers.update(1001, attributes)

    expected = @customers.find_by_id(1001)
    assert_equal "Smith", expected.last_name
    assert_equal "Joan", expected.first_name
    assert_operator original_time ,:<, expected.updated_at
  end

  def test_update_cannot_update_id_item_id_invoice_id_or_created_at
    skip
    attributes = {
                 :first_name => "Joan",
                 :last_name => "Clarke",
                 :created_at => Time.now,
                 :updated_at => Time.now
                 }
    @customers.create(attributes)
    attributes = {
                 id: 2000,
                 created_at: Time.now
                 }
    @customers.update(1001, attributes)
    assert_nil expected
    expected = @customers.find_by_id(1001)
    assert_equal attributes[:created_at], expected.created_at
  end

  def test_delete_deletes_the_specified_invoice
    skip
    attributes = {
                 :first_name => "Joan",
                 :last_name => "Clarke",
                 :created_at => Time.now,
                 :updated_at => Time.now
                 }
    @customers.create(attributes)
    @customers.delete(1001)
    expected = @customers.find_by_id(1001)
    assert_nil expected
  end
end
