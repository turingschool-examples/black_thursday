require_relative 'invoice_item'
require 'csv'
require 'pry'

class InvoiceItemRepository
  attr_reader :engine, :invoice_items

  def initialize(csvfile, engine)
    @engine        = engine
    @invoice_items = create_hash_of_invoice_items(csvfile)
  end

  def create_hash_of_invoice_items(csvfile)
    all_invoice_items = {}
    csvfile.each do |row|
      all_invoice_items[row[:id]] = InvoiceItem.new(row, self)
    end
    all_invoice_items
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  def all
    @invoice_items.values
  end

  def find_by_id(id)
    @invoice_items[id.to_s]
  end

  def find_all_by_item_id(item_id)
    array_of_matching_invoice_items = []
    all.find_all do |invoice_item|
      if invoice_item.item_id == item_id
        array_of_matching_invoice_items << invoice_item
      end
    end
  end

  def find_all_by_invoice_id(invoice_id)
    array_of_matching_invoice_items = []
    all.find_all do |invoice_item|
      if invoice_item.invoice_id == invoice_id
        array_of_matching_invoice_items << invoice_item
      end
    end
  end

end
