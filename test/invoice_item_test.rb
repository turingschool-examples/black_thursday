require_relative 'test_helper'
require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test

  def test_invoice_item_exists
    invoice_item = InvoiceItem.new({
      :id => 15, :item_id => 263533242, :invoice_id => 3,
      :quantity => 5, :unit_price => 72018,
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"}, self
    )

    assert_instance_of InvoiceItem, invoice_item
  end

  def test_invoice_item_has_id
    invoice_item = InvoiceItem.new({
      :id => 15, :item_id => 263533242, :invoice_id => 3,
      :quantity => 5, :unit_price => 72018,
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"}, self
    )
    id = invoice_item.id

    assert_equal 15, invoice_item.id
  end

  def test_invoice_item_has_item_id
    invoice_item = InvoiceItem.new({
      :id => 15, :item_id => 263533242, :invoice_id => 3,
      :quantity => 5, :unit_price => 72018,
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"}, self
    )
    item_id = invoice_item.item_id

    assert_equal 263533242, item_id
  end

  def test_invoice_item_has_invoice_id
    invoice_item = InvoiceItem.new({
      :id => 15, :item_id => 263533242, :invoice_id => 3,
      :quantity => 5, :unit_price => 72018,
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"}, self
    )
    invoice_id = invoice_item.invoice_id

    assert_equal 3, invoice_id
  end

  def test_invoice_item_has_quantity
    invoice_item = InvoiceItem.new({
      :id => 15, :item_id => 263533242, :invoice_id => 3,
      :quantity => 5, :unit_price => 72018,
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"}, self
    )
    quantity = invoice_item.quantity

    assert_equal 5, quantity
  end

  def test_invoice_item_has_unit_price
    invoice_item = InvoiceItem.new({
      :id => 15, :item_id => 263533242, :invoice_id => 3,
      :quantity => 5, :unit_price => 72018,
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"}, self
    )
    unit_price = invoice_item.unit_price

    assert_instance_of BigDecimal, unit_price
    assert_equal 720.18, unit_price.to_f
  end

  def test_unit_price_dollar_conversion
    invoice_item = InvoiceItem.new({
      :id => 15, :item_id => 263533242, :invoice_id => 3,
      :quantity => 5, :unit_price => 72018,
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"}, self
    )
    unit_price_in_cents = 72018.to_f
    unit_price = invoice_item.unit_price_in_dollars(unit_price_in_cents)

    assert_equal 720.18, unit_price
  end

  def test_invoice_item_has_created_at_date
    invoice_item = InvoiceItem.new({
      :id => 15, :item_id => 263533242, :invoice_id => 3,
      :quantity => 5, :unit_price => 72018,
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"}, self
    )
    created_at = invoice_item.created_at

    assert_instance_of Time, created_at
    assert_equal "2012-03-27 14:54:09 UTC", created_at.to_s
  end

  def test_invoice_item_has_updated_at_date
    invoice_item = InvoiceItem.new({
      :id => 15, :item_id => 263533242, :invoice_id => 3,
      :quantity => 5, :unit_price => 72018,
      :created_at => "2012-03-27 14:54:09 UTC",
      :updated_at => "2012-03-27 14:54:09 UTC"}, self
    )
    updated_at = invoice_item.updated_at

    assert_instance_of Time, updated_at
    assert_equal "2012-03-27 14:54:09 UTC", updated_at.to_s
  end

end
