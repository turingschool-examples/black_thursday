require 'simplecov'
require 'minitest/autorun'
require 'minitest/pride'
require 'bigdecimal'
require './lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def test_it_exist
    invoice_item = InvoiceItem.new({
                                    :id => 6,
                                    :item_id => 7,
                                    :invoice_id => 8,
                                    :quantity => 1,
                                    :unit_price => BigDecimal.new(10.99, 4),
                                    :created_at => Time.now,
                                    :updated_at => Time.now})

    assert_instance_of InvoiceItem, invoice_item
  end

  def test_it_has_an_id
    invoice_item = InvoiceItem.new({
                                    :id => 6,
                                    :item_id => 7,
                                    :invoice_id => 8,
                                    :quantity => 1,
                                    :unit_price => BigDecimal.new(10.99, 4),
                                    :created_at => Time.now,
                                    :updated_at => Time.now})

    assert_equal 6, invoice_item.id
  end

  def test_it_has_an_item_id
    invoice_item = InvoiceItem.new({
                                    :id => 6,
                                    :item_id => 7,
                                    :invoice_id => 8,
                                    :quantity => 1,
                                    :unit_price => BigDecimal.new(10.99, 4),
                                    :created_at => Time.now,
                                    :updated_at => Time.now})

    assert_equal 7, invoice_item.item_id
  end

  def test_it_has_an_invoice_id
    invoice_item = InvoiceItem.new({
                                    :id => 6,
                                    :item_id => 7,
                                    :invoice_id => 8,
                                    :quantity => 1,
                                    :unit_price => BigDecimal.new(10.99, 4),
                                    :created_at => Time.now,
                                    :updated_at => Time.now})

    assert_equal 8, invoice_item.invoice_id
  end

  def test_it_has_a_quantity
    invoice_item = InvoiceItem.new({
                                    :id => 6,
                                    :item_id => 7,
                                    :invoice_id => 8,
                                    :quantity => 1,
                                    :unit_price => BigDecimal.new(10.99, 4),
                                    :created_at => Time.now,
                                    :updated_at => Time.now})

    assert_equal 1, invoice_item.quantity
  end

  def test_it_has_a_unit_price
    invoice_item = InvoiceItem.new({
                                    :id => 6,
                                    :item_id => 7,
                                    :invoice_id => 8,
                                    :quantity => 1,
                                    :unit_price => BigDecimal.new(10.99, 4),
                                    :created_at => Time.now,
                                    :updated_at => Time.now})

    assert_equal BigDecimal, invoice_item.unit_price
  end

  def test_it_has_a_created_time
    invoice_item = InvoiceItem.new({
                                    :id => 6,
                                    :item_id => 7,
                                    :invoice_id => 8,
                                    :quantity => 1,
                                    :unit_price => BigDecimal.new(10.99, 4),
                                    :created_at => Time.now,
                                    :updated_at => Time.now})

    assert_equal Time, invoice_item.created_at
  end

  def test_it_has_an_updated_time
    invoice_item = InvoiceItem.new({
                                    :id => 6,
                                    :item_id => 7,
                                    :invoice_id => 8,
                                    :quantity => 1,
                                    :unit_price => BigDecimal.new(10.99, 4),
                                    :created_at => Time.now,
                                    :updated_at => Time.now})

    assert_equal Time, invoice_item.updated_at
  end
  
end
