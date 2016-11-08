require_relative 'invoice_item'
require 'pry'

class InvoiceItemRepository

  attr_reader   :parent,
                :all

  def initialize(invoice_item_data, parent = nil)
    @parent = parent
    @all = populate(invoice_item_data)
  end

  def populate(invoice_item_data)
    invoice_item_data.map { |invoice| InvoiceItem.new(invoice, self) }
  end

  def find_by_id(id)
    all.find { |invoice_item| invoice_item.id.eql?(id) }
  end

  def find_all_by_item_id(item_id)
    all.find_all { |invoice_item| invoice_item.item_id.eql?(item_id) }
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all { |invoice_item| invoice_item.invoice_id.eql?(invoice_id) }
  end

  def inspect
    "#<#{self.class} #{merchants.size} rows>"
  end
end