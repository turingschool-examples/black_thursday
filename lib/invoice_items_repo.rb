require_relative "invoice_item"
require_relative "sales_engine"
require 'csv'
require 'pry'

class InvoiceItemRepository
  attr_reader :invoice_items,
              :sales_engine

  def initialize(parent, filename)
    @invoice_items       = []
    @sales_engine        = parent
    @load                = load_file(filename)
  end

  def load_file(filename)
    invoice_item_csv = CSV.open filename,
                             headers: true,
                             header_converters: :symbol
    invoice_item_csv.map do |invoice_item| @invoice_items << InvoiceItems.new(invoice_item, self) end
  end

  def all
    invoice_items
  end

  def find_by_id(id)
    invoice_items.find { |invoice_item| invoice_item.id == id.to_i }
  end

  def find_all_by_item_id(item_id)
    invoice_items.find_all { |invoice_item| invoice_item.item_id == item_id }
  end

  def find_all_by_invoice_id(invoice_id)
    invoice_items.find_all { |invoice_item| invoice_item.invoice_id == invoice_id.to_i }
  end

  # def find_merchant(id)
  #   @sales_engine.find_merchant(id)
  # end

  def inspect
      "#<#{self.class} #{@invoice_items.size} rows>"
  end

end
