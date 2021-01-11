require_relative './test_helper'
require 'time'

class InvoiceItemRepositoryTest < Minitest::Test

  def setup
    item_path          = "./data/items.csv"
    merchant_path      = "./data/merchants.csv"
    invoice_path       = "./data/invoices.csv"
    invoice_item_path  = "./data/invoice_items.csv"
    arguments = {
                  :items     => item_path,
                  :merchants => merchant_path,
                  :invoices  => invoice_path,
                  :invoice_items => invoice_item_path
                }
    @engine = SalesEngine.from_csv(arguments)
    @invoice_item = @engine.invoice_items
  end



  def test_all_returns_an_array_of_all_invoice_item_instances
      expected = @invoice_item.all
      assert_equal 21830, expected.length
  end

  def test_find_by_id_finds_an_invoice_item_by_id

    id =10
    expected = @invoice_item.find_by_id(id)
    assert_equal id, expected.id
    assert_equal 263523644, expected.item_id
    assert_equal 2, expected.invoice_id
  end

  def test_find_by_id_returns_nil_if_the_invoice_item_does_not_exist
    id = 200000
    expected = @invoice_item.find_by_id(id)
    assert_nil expected
  end

  def test_find_all_by_item_id_finds_all_items_matching_given_item_id
    item_id = 263408101
    expected = @invoice_item.find_all_by_item_id(item_id)
    assert_equal 11, expected.length
    assert_equal InvoiceItem, expected.first.class
  end

#
#   it "#find_all_by_item_id finds all items matching given item_id" do
#     item_id = 263408101
#     expected = engine.invoice_items.find_all_by_item_id(item_id)
#
#     expect(expected.length).to eq 11
#     expect(expected.first.class).to eq InvoiceItem
#   end
#
#   it "#find_all_by_item_id returns an empty array if there are no matches" do
#     item_id = 10
#     expected = engine.invoice_items.find_all_by_item_id(item_id)
#
#     expect(expected.length).to eq 0
#     expect(expected.empty?).to eq true
#   end
#
#   it "#find_all_by_invoice_id finds all items matching given item_id" do
#     invoice_id = 100
#     expected = engine.invoice_items.find_all_by_invoice_id(invoice_id)
#
#     expect(expected.length).to eq 3
#     expect(expected.first.class).to eq InvoiceItem
#   end
#
#   it "#find_all_by_invoice_id returns an empty array if there are no matches" do
#     invoice_id = 1234567890
#     expected = engine.invoice_items.find_all_by_invoice_id(invoice_id)
#
#     expect(expected.length).to eq 0
#     expect(expected.empty?).to eq true
#   end
#
#   it "#create creates a new invoice item instance" do
#     attributes = {
#       :item_id => 7,
#       :invoice_id => 8,
#       :quantity => 1,
#       :unit_price => BigDecimal.new(10.99, 4),
#       :created_at => Time.now,
#       :updated_at => Time.now
#     }
#     engine.invoice_items.create(attributes)
#     expected = engine.invoice_items.find_by_id(21831)
#     expect(expected.item_id).to eq 7
#   end
#
#   it "#update updates an invoice item" do
#     original_time = engine.invoice_items.find_by_id(21831).updated_at
#     attributes = {
#       quantity: 13
#     }
#     engine.invoice_items.update(21831, attributes)
#     expected = engine.invoice_items.find_by_id(21831)
#     expect(expected.quantity).to eq 13
#     expect(expected.item_id).to eq 7
#     expect(expected.updated_at).to be > original_time
#   end
#
#   it "#update cannot update id, item_id, invoice_id, or created_at" do
#     attributes = {
#       id: 22000,
#       item_id: 32,
#       invoice_id: 53,
#       created_at: Time.now
#     }
#     engine.invoice_items.update(21831, attributes)
#     expected = engine.invoice_items.find_by_id(22000)
#     expect(expected).to eq nil
#     expected = engine.invoice_items.find_by_id(21831)
#     expect(expected.item_id).not_to eq attributes[:item_id]
#     expect(expected.invoice_id).not_to eq attributes[:invoice_id]
#     expect(expected.created_at).not_to eq attributes[:created_at]
#   end
#
#   it "#update on unknown invoice item does nothing" do
#     engine.invoice_items.update(22000, {})
#   end
#
#   it "#delete deletes the specified invoice" do
#     engine.invoice_items.delete(21831)
#     expected = engine.invoice_items.find_by_id(21831)
#     expect(expected).to eq nil
#   end
#
#   it "#delete on unknown invoice does nothing" do
#     engine.invoice_items.delete(22000)
#   end

end
