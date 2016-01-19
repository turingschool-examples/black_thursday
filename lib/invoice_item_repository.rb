require_relative 'invoice_item'
require          'csv'
require          'pry'
require          'bigdecimal'

class InvoiceItemRepository
  attr_reader :invoice_items

  def initialize(csv_hash)
    @invoice_items ||= csv_hash.map do |csv_hash|
      invoice_item = InvoiceItem.new(csv_hash)
    end
  end

  def all
    invoice_items
  end

  def find_by_id(invoice_id)
    invoice_items.find {|invoice_item| invoice_item.id == invoice_id.to_i}
  end

  def find_all_by_item_id(invoice_id)
    invoice_items.find_all {|invoice_item| invoice_item.item_id == invoice_id.to_i}
  end

  def find_all_by_invoice_id(invoice_id)
    invoice_items.find_all { |invoice_item| invoice_item.invoice_id == invoice_id.to_i}
  end


  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
