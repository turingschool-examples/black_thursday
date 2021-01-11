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
    @customer = @engine.customers
  end

  def test_all_returns_all_of_the_customers
    expected = @customer.all
    assert_equal 1000, expected.length
    assert_equal Customer, expected.first.class
  end

  def test_find_by_id_returns_the_customer_with_matching_id
    skip
    id = 100
    expected = @customer.find_by_id(id)
    assert_equal id, expected.id
    assert_equal Customer, expected.first.class
  end

  def test_find_all_by_first_name_returns_all_customers_with_matching_first_name
    fragment = "oe"
    expected = @customer.find_all_by_first_name(fragment)
    assert_equal 8, expected.length
    assert_equal Customer, expected.first.class
  end

  def test_find_all_by_last_name_return_all_customers_with_matching_last_name
    fragment = "On"
    expected = @customer.find_all_by_last_name(fragment)
    assert_equal 85, expected.length
    assert_equal Customer, expected.first.class
  end

  def test_find_all_by_first_name_and_find_all_by_last_name_are_case_insesntive
    fragment = "NN"
    expected = @customers.find_all_by_first_name(fragment)
    assert_equal 57, expected.length
    assert_operator Customer, expected.first.class

    fragment = "oN"
    expected = @customer.find_all_by_last_name(fragment)

    assert_equal 85, expected.length
    assert_equal Customer, expected.first.class
  end

    # it "#find_all_by_first_name and #find_all_by_last_name are case insensitive" do
    #   fragment = "NN"
    #   expected = engine.customers.find_all_by_first_name(fragment)
    #
    #   expect(expected.length).to eq 57
    #   expect(expected.first.class).to eq Customer
    #
    #   fragment = "oN"
    #   expected = engine.customers.find_all_by_last_name(fragment)
    #
    #   expect(expected.length).to eq 85
    #   expect(expected.first.class).to eq Customer
    # end
    #
    # it "#create creates a new customer instance" do
    #   attributes = {
    #     :first_name => "Joan",
    #     :last_name => "Clarke",
    #     :created_at => Time.now,
    #     :updated_at => Time.now
    #   }
    #   engine.customers.create(attributes)
    #   expected = engine.customers.find_by_id(1001)
    #   expect(expected.first_name).to eq "Joan"
    # end
    #
    # it "#update updates a customer" do
    #   original_time = engine.customers.find_by_id(1001).updated_at
    #   attributes = {
    #     last_name: "Smith"
    #   }
    #   engine.customers.update(1001, attributes)
    #   expected = engine.customers.find_by_id(1001)
    #   expect(expected.last_name).to eq "Smith"
    #   expect(expected.first_name).to eq "Joan"
    #   expect(expected.updated_at).to be > original_time
    # end
    #
    # it "#update cannot update id or created_at" do
    #   attributes = {
    #     id: 2000,
    #     created_at: Time.now
    #   }
    #   engine.customers.update(1001, attributes)
    #   expected = engine.customers.find_by_id(2000)
    #   expect(expected).to eq nil
    #   expected = engine.customers.find_by_id(1001)
    #   expect(expected.created_at).not_to eq attributes[:created_at]
    # end
    #
    # it "#update on unknown customer does nothing" do
    #   engine.customers.update(2000, {})
    # end
    #
    # it "#delete deletes the specified customer" do
    #   engine.customers.delete(1001)
    #   expected = engine.customers.find_by_id(1001)
    #   expect(expected).to eq nil
    # end
    #
    # it "#delete on unknown customer does nothing" do
    #   engine.customers.delete(2000)
    # end
  end
