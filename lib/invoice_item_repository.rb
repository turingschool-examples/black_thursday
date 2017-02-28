require_relative 'merchant'
require_relative 'sales_engine'
require_relative 'item_repository'
require_relative 'item'
require_relative 'merchant_repository'
require_relative 'invoice_item'
require_relative 'invoice'
require_relative 'invoice_repository'

class InvoiceItemRepository

  attr_reader :all

  def initialize(invoice_item_data)
    @all = invoice_item_data.map { |raw_data| InvoiceItem.new(raw_data, self)}
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
end
