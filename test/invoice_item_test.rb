require_relative './test_helper'
require './lib/invoice_item'
require 'time'
require 'bigdecimal'
require 'mocha/minitest'


class InvoiceItemTest < Minitest::Test
  def test_it_exists_and_has_attributes
    repo = mock
    invoice_item = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    }, repo)

    invoice_item_test_created_at = invoice_item.created_at.strftime("%d/%m/%Y")
    invoice_item_test_updated_at = invoice_item.updated_at.strftime("%d/%m/%Y")
    assert_instance_of InvoiceItem, invoice_item
    assert_equal 6, invoice_item.id
    assert_equal 7, invoice_item.item_id
    assert_equal 8, invoice_item.invoice_id
    assert_equal 1, invoice_item.quantity
    assert_equal BigDecimal(10.99, 4), invoice_item.unit_price
    assert_equal Time.now.strftime("%d/%m/%Y"), invoice_item_test_created_at
    assert_equal Time.now.strftime("%d/%m/%Y"), invoice_item.created_at.strftime("%d/%m/%Y")
    assert_equal Time.now.strftime("%d/%m/%Y"), invoice_item_test_updated_at
    assert_equal Time.now.strftime("%d/%m/%Y"), invoice_item.updated_at.strftime("%d/%m/%Y")
    assert_equal repo, invoice_item.repository
  end

  def test_unit_price_to_dollars
    repo = mock
    invoice_item_1 = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => "1099",
      :created_at => Time.now,
      :updated_at => Time.now
      }, repo)

    assert_equal 10.99, invoice_item_1.unit_price_to_dollars

    invoice_item_2 = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => "13000",
      :created_at => Time.now,
      :updated_at => Time.now
      }, repo)

    assert_equal 130.0, invoice_item_2.unit_price_to_dollars
    assert_equal Float, invoice_item_2.unit_price_to_dollars.class
  end
end
