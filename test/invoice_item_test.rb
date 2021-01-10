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
end

#
#   it "#unit_price returns the unit price" do
#     expect(invoice_item.unit_price).to eq 847.87
#     expect(invoice_item.unit_price.class).to eq BigDecimal
#   end
#
#   it "#created_at returns a Time instance for the date the invoice item was created" do
#     expect(invoice_item.created_at).to eq Time.parse("2012-03-27 14:54:35 UTC")
#     expect(invoice_item.created_at.class).to eq Time
#   end
#
#   it "#updated_at returns a Time instance for the date the invoice item was last updated" do
#     expect(invoice_item.updated_at).to eq Time.parse("2012-03-27 14:54:35 UTC")
#     expect(invoice_item.updated_at.class).to eq Time
#   end
# end
