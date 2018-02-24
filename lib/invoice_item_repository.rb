require 'csv'
require_relative 'invoice_item'
require 'pry'

class InvoiceItemRepository

  attr_reader :engine

  def initialize(filepath, parent = nil)
    @invoice_items    = []
    @engine           = parent
    load_items(filepath)
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  def all
    @invoice_items
  end

  def load_items(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @invoice_items << InvoiceItem.new(data, self)
    end
  end

  def find_by_id(id)
    @invoice_items.find { |invoice_item| invoice_item.id == id }
  end

  def find_all_by_item_id(id)
    @invoice_items.find_all { |invoice_item| invoice_item.item_id == id }
  end

  def find_all_by_invoice_id(id)
    @invoice_items.find_all { |invoice_item| invoice_item.invoice_id == id }
  end

end
