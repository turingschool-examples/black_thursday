require_relative 'test_helper'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  attr_reader :invoice_item_1, :invoice_item_2, :parent

  def setup
    @parent = Minitest::Mock.new
    @invoice_item_1 = InvoiceItem.new({:id => '1',
                                      :item_id => '263519844',
                                      :invoice_id => '1',
                                      :quantity => '5',
                                      :unit_price => '13635',
                                      :created_at => '2012-03-27 14:54:09 UTC',
                                      :updated_at => '2012-03-27 14:54:09 UTC'},
                                      parent)
    @invoice_item_2 = InvoiceItem.new({:id => '2',
                                      :item_id => '263454779',
                                      :invoice_id => '1',
                                      :quantity => '9',
                                      :unit_price => '23324',
                                      :created_at => '2012-03-27 14:54:09 UTC',
                                      :updated_at => '2012-03-27 14:54:09 UTC'}, 
                                      parent)
  end

  def test_invoice_items_have_idividual_ids
    assert_equal 1, invoice_item_1.id
    assert_equal 2, invoice_item_2.id
  end

  def test_invoice_items_have_individual_item_ids
    assert_equal 263519844, invoice_item_1.item_id
    assert_equal 263454779, invoice_item_2.item_id
  end

  def test_invoices_items_have_invoice_ids
    assert_equal 1, invoice_item_1.invoice_id
    assert_equal 1, invoice_item_2.invoice_id
  end

  def test_invoice_items_have_indivdual_quantities
    assert_equal 5, invoice_item_1.quantity
    assert_equal 9, invoice_item_2.quantity
  end

  def test_invoice_items_have_created_on_dates
    assert_equal 2012, invoice_item_1.created_at.year
    assert_equal 2012, invoice_item_2.created_at.year
  end

  def test_invoice_items_have_updated_on_dates
    assert_equal 2012, invoice_item_1.updated_at.year
    assert_equal 2012, invoice_item_2.updated_at.year
  end

  def test_unit_price_returns_big_decimal
    assert_equal Float, invoice_item_1.unit_price_to_dollars.class
  end

  def test_unit_price_in_dollars_returns_float
    assert_equal Float, invoice_item_1.unit_price_to_dollars.class
  end
end