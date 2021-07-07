# Frozen_string_literal: true

require './test/test_helper'
require './lib/sales_engine'
require './lib/invoice_repository'
# Invoice Repository
class InvoiceRepositoryTest < Minitest::Test
  attr_reader :se
  def setup
    @se = SalesEngine.from_csv({:invoices => "./data/invoices.csv"})
  end

  def test_it_exists
    assert_instance_of InvoiceRepository, se.invoices
  end

  def test_it_returns_all_invoices
    assert_equal 4985, se.invoices.all.count
    assert_instance_of Array, se.invoices.all
    assert_instance_of Invoice, se.invoices.all[0]
  end

  def test_it_has_id
    assert_instance_of Invoice, se.invoices.find_by_id(1)
    assert_equal '1', se.invoices.find_by_id(1).customer_id
    assert_nil se.invoices.find_by_id(4989)
  end

  def test_find_by_customer_id
    assert_equal '1', se.invoices.find_all_by_customer_id(1)[0].customer_id
  end

  def test_find_all_by_id
    assert_instance_of Array, se.invoices.find_all_by_merchant_id(12335938)
    assert_instance_of Invoice, se.invoices.find_all_by_merchant_id(12335938)[0]
    assert_equal '1', se.invoices.find_all_by_merchant_id(12335938)[0].customer_id
  end

  def test_it_can_find_status
    assert_equal 1, se.invoices.find_all_by_status("pending")[0].id
    assert_equal 2, se.invoices.find_all_by_status("shipped")[0].id
  end

  def test_create_new_invoices_with_attributes
    attributes = {
                :customer_id => 7,
                :merchant_id => 8,
                :status      => "pending",
                :created_at  => Time.now,
                :updated_at  => Time.now,
                }

    assert_equal 4986, se.invoices.create(attributes).id
  end

  def test_it_can_update
    attributes = {
                :customer_id => 2,
                :merchant_id => 2,
                :status      => 'success',
                :created_at  => Time.now,
                :updated_at  => Time.now,
                }
    id = '2'
    assert_equal 'success', se.invoices.update(id, attributes[:status])
  end

  def test_it_can_delete_an_invoice
    assert_instance_of Invoice, se.invoices.delete(1)
    assert_equal 4984, se.invoices.all.count
  end
end
