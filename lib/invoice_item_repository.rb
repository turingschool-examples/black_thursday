require_relative 'helper'

class InvoiceItemRepository

  attr_reader :all,
              :parent

  def initialize(invoice_item_data, parent)
    @all = invoice_item_data.map { |raw_data| InvoiceItem.new(raw_data, self)}
    @parent = parent
  end

  def find_by_id(id)
    all.find do |invoice_item|
      id == invoice_item.id
    end
  end

  def find_all_by_item_id(item_id)
    all.find_all do |invoice_item|
      item_id == invoice_item.item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    all.find_all do |invoice_item|
      invoice_id == invoice_item.invoice_id
    end
  end

  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end
end
