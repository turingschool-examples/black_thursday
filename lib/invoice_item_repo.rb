require_relative "sales_engine"
require_relative "invoice_item"
require "csv"

class InvoiceItemRepo
  attr_reader :invoice_items,
              :sales_engine

  def initialize(sales_engine, filename)
    @invoice_items = []
    @sales_engine  = sales_engine
    load_invoice_items(filename)
  end

  def load_invoice_items(filename)
    invoice_item_csv = CSV.open filename,
                            headers: true,
                            header_converters: :symbol,
                            converters: :numeric
    invoice_item_csv.each do |row| @invoice_items << InvoiceItem.new(row, self)
    end
  end

  def all
    invoice_items
  end

  def find_by_id(id)
    invoice_items.find { |invoice_item| invoice_item.id == id }
  end

  def find_all_by_item_id(item_id)
    invoice_items.find_all { |invoice_item| invoice_item.item_id == item_id }
  end

  def find_all_by_invoice_id(invoice_id)
    invoice_items.find_all do |invoice_item|
      invoice_item.invoice_id == invoice_id
    end
  end

  def find_item_by_item_id(id)
    sales_engine.find_item_by_item_id(id)
  end
end
