require_relative 'invoice_item'
require          'csv'
require          'pry'
require          'bigdecimal'

class InvoiceItemRepository
  attr_reader :invoice_item_instances

  def initialize(csv_hash)
    @invoice_item_instances = csv_hash.map do |csv_hash|
      item_invoice = InvoiceItem.new(csv_hash)
    end
  end

  def all
    @invoice_item_instances
  end
  
end
