require 'csv'
require './lib/invoice_item'

class InvoiceItemRepository

  def initialize
    @invoice_items      = []
  end

  def from_csv(file)
    CSV.readlines(file, headers: true, header_converters: :symbol) do |row|
      invoice_items << InvoiceItem.new(row)
    end
  end

  def all
    return invoice_items
  end

  def find_by_id(id)
    invoice_items.find do |invoice_item|
      invoice_item.id.to_i == id.to_i
    end
  end

  def find_all_by_item_id

  end

  # all - returns an array of all known InvoiceItem instances
  # find_by_id - returns either nil or an instance of InvoiceItem with a matching ID
  # find_all_by_item_id - returns either [] or one or more matches which have a matching item ID
  # find_all_by_invoice_id - returns either [] or one or more matches which have a matching invoice ID
  #


end
