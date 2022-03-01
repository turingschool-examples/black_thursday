# invoice_item_repository
require 'pry'



class InvoiceItemsRepository
  attr_reader :invoice_items

  def initialize(invoice_items)
    @invoice_items = invoice_items
  end

  def all
    @invoice_items
  end
end
