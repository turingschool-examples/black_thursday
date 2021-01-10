require_relative './test_helper'
require 'time'

class InvoiceItemTest < Minitest::Test

  def setup
    item_path          = "./data/items.csv"
    merchant_path      = "./data/merchants.csv"
    invoice_path       = "./data/invoices.csv"
    invoice_item_path  = "./data/invoice_items.csv"
    arguments = {
                  :items     => item_path,
                  :merchants => merchant_path,
                  :invoices  => invoice_path,
                  :invoice_item => invoice_item_path
                }
    @engine = SalesEngine.from_csv(arguments)
    @invoice_item = engine.invoice_items.find_by_id(2345)
  end
  # context "Invoice Item" do
#   let(:invoice_item) { engine.invoice_items.find_by_id(2345) } #notsure if i need this
  def test_it_exists
    assert_instance_of InvoiceItem, @invoice_item
  end

  def test_id_returns_the_invoice_item_id
    skip
    assert_equal 2345, invoice_item.id
    assert_equal Fixnum, invoice_item.id.class
  end

  def test_item_id_returns_the_item_id
    assert_equal 263562118, invoice_item.item_id
    assert_equal Fixnum, invoice_item.item_id.class
  end

  def test_invoice_id_returns_the_invoice_id
    assert_equal 522, invoice_item.invoice_id
    assert_equal Fixnum, invoice_item.invoice_id.class
  end

  def test_unit_price_returns_the_unit_price
    assert_equal 857.87, invoice_item.unit_price
    assert_equal BigDecimal, invoice_item.unit_price.class
  end

  def test_created_at_returns_a_time_instance_for_the_date_the_invoice_item_was_created
    assert_equal  Time.parse("2012-03-27 14:54:35 UTC"), invoice_item.created_at
    assert_equal Time, invoice_item.created_at.class
  end

  def test_updated_at_returns_a_time_instance_for_the_date_the_invoice_item_was_last_updated
    assert_equal Time.parse("2012-03-27 14:54:35 UTC"), invoice_item.updated_at
    assert_equal Time, invoice_item.updated_at.class
  end
end
