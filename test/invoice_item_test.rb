require './test/test_helper'
require './lib/sales_engine'

class InvoiceItemTest < Minitest::Test

  def test_that_it_has_an_id
    ii = InvoiceItem.new({ id: 11, item_id: 263532898, invoice_id: 2, quantity: 3, unit_price: 30949, created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC" })

    assert_equal 11, ii.id
  end

  def test_that_it_has_an_item_id
    ii = InvoiceItem.new({ id: 11, item_id: 263532898, invoice_id: 2, quantity: 3, unit_price: 30949, created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC" })

    assert_equal 263532898, ii.item_id
  end

  def test_that_it_has_an_invoice_id
    ii = InvoiceItem.new({ id: 11, item_id: 263532898, invoice_id: 2, quantity: 3, unit_price: 30949, created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC" })

    assert_equal 2, ii.invoice_id
  end

  def test_that_it_has_a_quantity
    ii = InvoiceItem.new({ id: 11, item_id: 263532898, invoice_id: 2, quantity: 3, unit_price: 30949, created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC" })

    assert_equal 3, ii.quantity
  end

  def test_that_it_has_a_unit_price_given_a_big_decimal
    ii = InvoiceItem.new({ id: 11, item_id: 263532898, invoice_id: 2, quantity: 3, unit_price: BigDecimal.new(309.49, 5), created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC" })

    assert_equal BigDecimal(309.49, 5), ii.unit_price
  end

  def test_that_it_has_a_unit_price_given_a_string
    ii = InvoiceItem.new({ id: 11, item_id: 263532898, invoice_id: 2, quantity: 3, unit_price: "30949", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC" })

    assert_equal BigDecimal(309.49, 5), ii.unit_price
  end

  def test_that_it_has_a_unit_price_given_an_integer
    ii = InvoiceItem.new({ id: 11, item_id: 263532898, invoice_id: 2, quantity: 3, unit_price: 30949, created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC" })

    assert_equal BigDecimal(309.49, 5), ii.unit_price
  end

  def test_that_it_finds_when_created
    ii = InvoiceItem.new({ id: 11, item_id: 263532898, invoice_id: 2, quantity: 3, unit_price: 30949, created_at: "2012-03-27 14:54:07 UTC", updated_at: "2012-03-27 14:54:07 UTC" })

    assert_equal Time.new(2012, 03, 27, 14, 54, 07, "-00:00"), ii.created_at
  end

  def test_that_it_finds_when_updated
    ii = InvoiceItem.new({ id: 11, item_id: 263532898, invoice_id: 2, quantity: 3, unit_price: 30949, created_at: "2012-03-27 14:54:07 UTC", updated_at: "2012-03-27 14:54:07 UTC" })

    assert_equal Time.new(2012, 03, 27, 14, 54, 07, "-00:00"), ii.updated_at
  end

  def test_it_can_convert_unit_price_to_dollars
    ii = InvoiceItem.new({ id: 11, item_id: 263532898, invoice_id: 2, quantity: 3, unit_price: 30949, created_at: "2012-03-27 14:54:07 UTC", updated_at: "2012-03-27 14:54:07 UTC" })

    assert_equal 309.49, ii.unit_price_to_dollars
  end

  def test_it_points_to_its_item
    se = SalesEngine.from_csv({ invoice_items: "./test/samples/invoice_items_sample.csv", items: "./test/samples/item_sample.csv"})
    ii = se.invoice_items.find_by_id(20)

    assert_equal "510+ RealPush Icon Set", ii.item.name
  end

end
