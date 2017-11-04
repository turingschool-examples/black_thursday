require 'csv'
require_relative '../lib/invoice_item'
require_relative '../lib/create_elements'

class InvoiceItemRepository

  include CreateElements

  attr_reader :invoice_items, :engine

  def initialize(items_file, engine)
    @invoice_items      = create_elements(items_file).map {|item_invoice| InvoiceItem.new(item_invoice, self)}
    @engine = engine
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

  def inspect
      "#<#{self.class} #{@invoice_items.size} rows>"
  end

end
