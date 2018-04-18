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

  def test_find_by_name
    assert_equal 1, se.invoices.find_all_by_customer_id('1').id
    assert_nil se.invoices.find_all_by_customer_id('morty')
  end

  def test_find_all_by_name
skip
    assert_instance_of Array, se.invoices.find_all_by_name('Candisart')
    assert_instance_of Invoice, se.invoices.find_all_by_name('Can')[0]
    assert_equal 2, se.invoices.find_all_by_name('Can').count
    assert_equal 12_334_112, se.invoices.find_all_by_name('Candisart')[0].id
  end

  def test_create_new_invoices_with_attributes
skip
    attributes = {
        name: "Turing School of Software and Design"
      }

    assert_equal 12_334_124, se.invoices.create(attributes).id
  end
end
