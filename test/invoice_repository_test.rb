# frozen_string_literal: false

require_relative 'test_helper'
require './lib/sales_engine'
require './lib/invoice_repository'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv(invoices: './data/invoices.csv')
    @ir = @se.invoices
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, @ir
  end

  def test_it_has_attributes
    assert_equal 4985, @ir.all.length
  end

  def test_all_returns_array_of_all_invoice_objects
    invoices = @ir.all
    assert invoices.all? do |invoice|
      invoice.class == Invoice
    end
  end

  def test_find_by_id_returns_invoices_for_given_id
    assert_instance_of Invoice, @ir.find_by_id(2)
    assert_equal 1, @ir.find_by_id(2).customer_id
    assert_equal 12_334_753, @ir.find_by_id(2).merchant_id
    assert_equal :shipped, @ir.find_by_id(2).status
  end

  def test_find_by_id_refutes_empty_and_nil_cases
    refute @ir.find_by_id('notarealid')
    refute @ir.find_by_id('')
    refute @ir.find_by_id(nil)
  end

  def test_find_all_by_customer_id_returns_invoices_for_given_id
    assert_equal 5, @ir.find_all_by_customer_id(6).length
    assert_equal 2, @ir.find_all_by_customer_id(99).length
  end

  def test_find_all_by_merchant_id
    assert_equal 15, @ir.find_all_by_merchant_id(12_334_753).length
  end

  def test_find_all_by_status
    assert_equal 1473, @ir.find_all_by_status(:pending).length
    assert_equal 673, @ir.find_all_by_status(:returned).length
    assert_equal 2839, @ir.find_all_by_status(:shipped).length
  end

  def test_all_status_accounted_for
    actual = (@ir.find_all_by_status(:pending) +
    @ir.find_all_by_status(:returned) +
    @ir.find_all_by_status(:shipped)).length
    assert_equal 4985, actual
  end

  def test_it_can_find_the_highest_id
    assert_equal 4985, @ir.find_highest_id.id
  end

  def test_it_can_create_a_new_invoice_object
    attributes = {
      customer_id: 12,
      merchant_id: 24,
      status: 'pending',
      created_at: Time.now,
      updated_at: Time.now
    }
    @ir.create(attributes)
    assert_equal 24, @ir.find_by_id(4986).merchant_id
    assert_instance_of Invoice, @ir.find_by_id(4986)
  end

  def test_it_can_update_invoice_status
    assert_equal :shipped, @ir.find_by_id(34).status
    @ir.update(34, status: :returned)

    assert_equal :returned, @ir.find_by_id(34).status
    assert_equal Time.parse('2015-01-24'), @ir.find_by_id(34).created_at
    assert_equal 2018, @ir.find_by_id(34).updated_at.year
  end

  def test_it_can_delete_an_invoice_object
    assert @ir.find_by_id(4985)
    @ir.delete(4985)

    assert_equal 4984, @ir.find_highest_id.id
    refute @ir.find_by_id(4985)
  end
end
