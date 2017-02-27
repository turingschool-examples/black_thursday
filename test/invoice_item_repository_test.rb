require './test/test_helper'
require './lib/sales_engine'
require './lib/invoice_item_repository'
require './lib/invoice_item'

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :merchants => "./data/merchants.csv",
      :items     => "./data/items.csv",
      :customers => "./data/customers.csv",
      :invoices  => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions  => "./data/transactions.csv"
      })

    @iir = @se.invoice_items
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, @iir
  end

  def test_it_can_create_instance_of_invoice_item
    assert_instance_of InvoiceItem, @iir.all.first
  end

  def test_all_returns_an_array
    assert_instance_of Array, @iir.all
  end

  def test_all_contains_proper_number_of_invoice_items
    assert_equal 21830, @iir.all.count
    assert_equal InvoiceItem, @iir.all.first.class
  end

  def test_it_can_find_invoice_item_by_id
    invoice_item = @iir.find_by_id(1)
    assert_instance_of InvoiceItem, invoice_item
  end

  def test_it_returns_nil_if_no_invoice_item_id_exists
    invoice_item = @iir.find_by_id(0)
    assert_nil invoice_item
  end

  def test_it_returns_array_with_find_all_by_item_id
    invoice_item = @iir.find_all_by_item_id(263519844)
    assert_instance_of Array, invoice_item
  end

  def test_it_returns_array_with_find_all_by_invoice_id
    invoice_item = @iir.find_all_by_invoice_id(1)
    assert_instance_of Array, invoice_item
  end

  def test_it_returns_empty_array_if_none_match_item_id
    invoice_item = @iir.find_all_by_item_id(0)
    assert_equal [], invoice_item
  end

  def test_it_returns_empty_array_if_none_match_invoice_id
    invoice_item = @iir.find_all_by_invoice_id(0)
    assert_equal [], invoice_item
  end
end
