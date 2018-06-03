require_relative 'test_helper'
require_relative 'test_helper'
require_relative '../lib/sales_engine'
require_relative '../lib/invoice_repository'
require 'minitest/autorun'
require 'minitest/pride'
class InvoiceRepositoryTest < Minitest::Test
  def setup
    @engine = SalesEngine.from_csv({
      items: './data/items.csv',
      merchants: './data/merchants.csv',
      customers: './data/customers.csv',
      invoices: './data/invoices.csv',
      invoice_items: './data/invoice_items.csv',
      transactions: './data/transactions.csv'
    })
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @engine.invoices
  end

  def test_all_returns_all_invoices
    expected = @engine.invoices.all

    assert_equal 4985, expected.length
  end

  def test_find_by_id_returns_an_invoice_associated_to_the_given_id
    invoice_id = 3452
    expected = @engine.invoices.find_by_id(invoice_id)
    assert_equal invoice_id, expected.id
    assert_equal 12335690, expected.merchant_id
    assert_equal 679, expected.customer_id
    assert_equal :pending, expected.status
    invoice_id = 5000
    expected = @engine.invoices.find_by_id(invoice_id)
    assert_nil expected
  end

  def test_find_all_by_customer_id_returns_all_invoices_associated_with_customer
    customer_id = 300
    expected = @engine.invoices.find_all_by_customer_id(customer_id)
    assert_equal 10, expected.length
    customer_id = 1000
    expected = @engine.invoices.find_all_by_customer_id(customer_id)
    assert_equal [], expected
  end

  def test_find_all_by_merchant_id_returns_all_invoices_associated_with_id
    merchant_id = 12335080
    expected = @engine.invoices.find_all_by_merchant_id(merchant_id)
    assert_equal 7, expected.length
    merchant_id = 1000
    expected = @engine.invoices.find_all_by_merchant_id(merchant_id)
    assert_equal [], expected
  end

  def test_find_all_by_status_returns_all_invoices_associated_with_status
    status = :shipped
    expected = @engine.invoices.find_all_by_status(status)
    assert_equal 2839, expected.length
    status = :pending
    expected = @engine.invoices.find_all_by_status(status)
    assert_equal 1473, expected.length
    status = :sold
    expected = @engine.invoices.find_all_by_status(status)
    assert_equal [], expected
  end

  def test_create_creates_a_new_invoice_instance
    attributes = {
      :customer_id => 7,
      :merchant_id => 8,
      :status      => 'pending',
      :created_at  => Time.now,
      :updated_at  => Time.now,
    }
    @engine.invoices.create(attributes)
    expected = @engine.invoices.find_by_id(4986)
    assert_equal 7, expected.customer_id
    assert_equal 8, expected.merchant_id
    assert_equal :pending, expected.status
  end

  def test_update_updates_an_invoice
    attributes = {
      :customer_id => 7,
      :merchant_id => 8,
      :status      => :pending,
      :created_at  => Time.now,
      :updated_at  => Time.now,
    }
    @engine.invoices.create(attributes)
    original_time = @engine.invoices.find_by_id(4986).updated_at
    attributes = {
      status: :success
    }
    @engine.invoices.update(4986, attributes)
    expected = @engine.invoices.find_by_id(4986)
    assert_equal :success, expected.status
    assert_equal 7, expected.customer_id
    assert expected.updated_at > original_time
  end

  def test_update_cannot_update_id_customer_id_merchant_id_or_created_at
    attributes = {
      :customer_id => 7,
      :merchant_id => 8,
      :status      => 'pending',
      :created_at  => Time.now,
      :updated_at  => Time.now,
    }
    updated_attributes = {
      id: 5000,
      customer_id: 2,
      merchant_id: 3,
      created_at: Time.now
    }
    @engine.invoices.create(attributes)
    @engine.invoices.update(4986, updated_attributes)
    expected = @engine.invoices.find_by_id(5000)
    assert_nil expected
    expected = @engine.invoices.find_by_id(4986)
    assert updated_attributes[:customer_id] != expected.customer_id
    assert updated_attributes[:merchant_id] != expected.customer_id
    assert updated_attributes[:created_at] != expected.created_at
  end

  def test_update_on_unkown_invoice_does_nothing
    expected = @engine.invoices.update(5000, {})
    assert_nil expected
  end

  def test_delete_deletes_the_specified_invoice
    attributes = {
      :customer_id => 7,
      :merchant_id => 8,
      :status      => 'pending',
      :created_at  => Time.now,
      :updated_at  => Time.now,
    }

    @engine.invoices.create(attributes)
    assert @engine.invoices.find_by_id(4986)
    @engine.invoices.delete(4986)
    refute @engine.invoices.find_by_id(4986)
  end

  def test_delete_on_unknown_invoice_does_nothing
    expected = @engine.invoices.delete(5000)
    assert_nil expected
  end

end
