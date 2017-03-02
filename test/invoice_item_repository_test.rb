require_relative 'test_helper'
require_relative '../lib/invoice_item_repository'
require_relative 'sales_engine_methods'

class InvoiceItemRepositoryTest < Minitest::Test
  include SalesEngineMethods
  attr_reader :iir, :se

  def setup
    create_sales_engine
    @iir = InvoiceItemRepository.new
    iir.from_csv("./test/fixtures/invoice_items_test.csv")
  end

  def test_it_exists
    assert_instance_of InvoiceItemRepository, iir
  end

  def test_it_knows_all_invoice_items
    assert_instance_of InvoiceItem, iir.all.first
    assert_equal 13, iir.all.count
  end

  def test_it_can_find_invoice_item_by_id
    assert_instance_of InvoiceItem, iir.find_by_id(5)
    assert_equal 263394417, iir.find_by_id(5).item_id
    assert_nil iir.find_by_id(31)
  end

  def test_it_can_find_all_with_given_item_id
    assert_equal Array, iir.find_all_by_item_id(263519844).class
    assert_equal 1, iir.find_all_by_item_id(263519844).count
    assert_equal 136.35, iir.find_all_by_item_id(263519844).first.unit_price_to_dollars
    assert_equal 1, iir.find_all_by_item_id(263553176).count
    assert_equal 12, iir.find_all_by_item_id(263553176).last.id
  end

  def test_it_can_find_all_by_invoice_id
    assert_equal Array, iir.find_all_by_invoice_id(22).class
    assert_equal 4, iir.find_all_by_invoice_id(22).count
    assert_equal 263529264, iir.find_all_by_invoice_id(22).first.item_id
    assert_equal 0, iir.find_all_by_invoice_id(10).count
  end

  def test_it_knows_invoice_items_paid_in_full
    iir = se.invoice_items
    assert_instance_of Array, iir.invoice_items_paid_in_full
    assert_instance_of InvoiceItem, iir.invoice_items_paid_in_full.first
    assert_equal 6, iir.invoice_items_paid_in_full.count
    assert_equal 263519844, iir.invoice_items_paid_in_full.first.item_id
  end

end
