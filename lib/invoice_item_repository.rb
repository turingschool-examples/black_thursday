require 'pry'
require_relative "invoice_item"
require_relative "sales_engine"
require 'csv'

class InvoiceItemRepository
  attr_reader :sales_engine, :invoice_items

  def initialize(value_at_invoice_item, sales_engine)
    @invoice_items = []
    @sales_engine = sales_engine
    make_invoice_items(value_at_invoice_item)
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  def make_invoice_items(invoice_item_hashes)
    invoice_item_hashes.each do |invoice_item_hash|
      @invoice_items << InvoiceItem.new(invoice_item_hash, self)
    end
    @invoice_items
  end

  def all
    @invoice_items
  end

  def find_by_id(id)
    @invoice_items.find { |object| object.id == id }
  end

  def find_all_by_item_id(id)
    @invoice_items.find_all { |object| object.item_id == id }
  end

  def find_all_by_invoice_id(id)
    @invoice_items.find_all { |object| object.invoice_id == id }
  end
end
