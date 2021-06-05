require 'csv'
require_relative 'invoice_item'

class InvoiceItemRepository

  def initialize(path)
    @all = []
    # create_items(path)
  end
end
