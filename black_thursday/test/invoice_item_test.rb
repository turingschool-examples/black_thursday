require_relative 'test_helper'
require 'bigdecimal'
require 'time' 
require 'csv'
require_relative './../lib/invoice_item'
require_relative './../lib/item_repository'

class InvoiceItemTest < Minitest::Test
  attr_reader :repository
  
    def setup
      @engine = SalesEngine.from_csv(
        items: './test/fixtures/truncated_items.csv',
        merchants: './test/fixtures/truncated_merchants.csv',
        invoices: './test/fixtures/truncated_invoices.csv',
        transactions: './test/fixtures/truncated_transactions.csv',
        invoice_items: './test/fixtures/truncated_invoice_items.csv'
      )
      @repository = InvoiceRepository.new('./test/fixtures/truncated_invoice_items.csv', @engine)
    end

    def test_it_exists
      created_at = "2012-03-27 14:54:09 UTC"
      updated_at = "2012-03-27 14:54:09 UTC"
  
      invoice_item = InvoiceItem.new(
        {id: "1",
        item_id: "263519844",
        invoice_id: "1",
        quantity: "5",
        unit_price: "13635",
        created_at: created_at,
        updated_at: updated_at},
        repository
      )
      
      assert_instance_of InvoiceItem, invoice_item
    end

    def test_it_can_hold_attributes
      created_at = "2012-03-27 14:54:09 UTC"
      updated_at = "2012-03-27 14:54:09 UTC"
  
      invoice_item = InvoiceItem.new(
        {id: "1",
        item_id: "263519844",
        invoice_id: "1",
        quantity: "5",
        unit_price: "13635",
        created_at: created_at,
        updated_at: updated_at},
        repository
      )

      assert_equal 1, invoice_item.id
      assert_equal 263519844, invoice_item.item_id
      assert_equal 1, invoice_item.invoice_id
      assert_equal 5, invoice_item.quantity
      assert_equal 136.35, invoice_item.unit_price
      assert_equal Time.parse("2012-03-27 14:54:09 UTC"), invoice_item.created_at
      assert_equal Time.parse("2012-03-27 14:54:09 UTC"), invoice_item.updated_at
    end

end