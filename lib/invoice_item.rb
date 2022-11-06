require_relative 'make_time'

class InvoiceItem 
  include MakeTime

  attr_reader

  def initialize(invoice_item_data)
end