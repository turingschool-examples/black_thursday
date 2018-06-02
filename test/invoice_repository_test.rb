require './test_helper'
require './lib/invoice'
require './lib/invoice_repository'
require './lib/file_loader'
require './lib/sales_engine'
require 'bigdecimal'
require 'pry'

class InvoiceRepositoryTest < MiniTest::Test
  def setup
    se = SalesEngine.from_csv({
    :items => "./data/mock.csv",
    :merchants => "./data/mock.csv",
    :invoices => "./data/invoices.csv",
    :invoice_items => "./data/mock.csv",
    :transactions => "./data/mock.csv",
    :customers => "./data/mock.csv"
    })

    @ir = se.invoices
  end

  def test_it_returns_array_of_all_invoices
    assert_equal 4985, @ir.all.length
  end

  def test_it_can_find_by_invoice_id
    invoice = @ir.find_by_id(3452)

    assert_instance_of Invoice, invoice
    assert_equal 3452, invoice.id
    assert_equal 12335690, invoice.merchant_id
    assert_equal 679, invoice.customer_id
    assert_equal :pending, invoice.status
  end

  def test_it_returns_nill_if_you_try_to_find_nonexistant_invoice
    assert_nil @ir.find_by_id(5000)
  end

  def test_it_can_find_all_by_customer_id
    assert_equal 10, @ir.find_all_by_customer_id(300).length
  end

  def test_it_returns_empty_array_if_customer_doesnt_exist
    assert_equal [], @ir.find_all_by_customer_id(1000)
  end

  def test_it_can_find_all_by_merchant_id
    assert_equal 7, @ir.find_all_by_merchant_id(12335080).length
  end

  def test_it_returns_empty_array_if_merchant_doesnt_exist
    assert_equal [], @ir.find_all_by_merchant_id(1000)
  end

  def test_it_can_find_all_by_status
    assert_equal 2839, @ir.find_all_by_status(:shipped).length
    assert_equal 1473, @ir.find_all_by_status(:pending).length
  end

  def test_it_returns_empty_array_if_status_is_sold
    assert_equal [], @ir.find_all_by_status(:sold)
  end

  def test_it_can_create_new_invoice
    attributes = {
      :customer_id => 7,
      :merchant_id => 8,
      :status      => 'pending',
      :created_at  => Time.now,
      :updated_at  => Time.now
    }
    @ir.create(attributes)
    new_invoice = @ir.find_by_id(4986)

    assert_equal 8, new_invoice.merchant_id
  end

  def test_it_can_update_invoice
    attributes = {
      :customer_id => 7,
      :merchant_id => 8,
      :status      => 'pending',
      :created_at  => Time.now,
      :updated_at  => Time.now
    }
    @ir.create(attributes)

    updated_attributes = {
      :status => :success
    }
    updated_invoice = @ir.find_by_id(4986)
    original_time = updated_invoice.updated_at
    @ir.update(4986, updated_attributes)
    assert_equal :success, updated_invoice.status
    assert_equal 7, updated_invoice.customer_id
    assert updated_invoice.updated_at > original_time
  end

  def test_it_cannot_update_anything_besides_status
    attributes = {
      :customer_id => 7,
      :merchant_id => 8,
      :status      => 'pending',
      :created_at  => Time.now,
      :updated_at  => Time.now
    }
    @ir.create(attributes)

    updated_attributes = {
      :id => 5000,
      :customer_id => 2,
      :merchant_id => 3,
      :created_at => Time.now,
    }
    updated_invoice = @ir.find_by_id(4986)
    @ir.update(4986, updated_attributes)

    assert_nil @ir.find_by_id(5000)
    refute_equal updated_attributes[:customer_id], updated_invoice.customer_id
    refute_equal updated_attributes[:merchant_id], updated_invoice.merchant_id
    refute_equal updated_attributes[:created_at], updated_invoice.created_at
  end

  def test_it_does_nothing_if_you_try_to_update_nonexistant_invoice
    assert_nil @ir.update(5000, {})
  end

  def test_it_can_delete_invoice_by_id
    attributes = {
      :customer_id => 7,
      :merchant_id => 8,
      :status      => 'pending',
      :created_at  => Time.now,
      :updated_at  => Time.now
    }
    @ir.create(attributes)
    assert_instance_of Invoice, @ir.find_by_id(4986)
    @ir.delete(4986)
    assert_nil @ir.find_by_id(4986)
  end

  def test_it_returns_nil_if_you_try_to_delete_nonexistant_ivoice
    assert_nil @ir.delete(5000)
  end
end
