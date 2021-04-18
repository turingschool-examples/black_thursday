require_relative '../lib/invoice_item'
require_relative '../lib/repository'
require 'bigdecimal/util'

class InvoiceItemRepository < Repository

  def initialize(path)
    super(path)
    @array_of_objects = create_invoice_item(@parsed_csv_data)
  end

  def create_invoice_item(parsed_csv_data)
    parsed_csv_data.map do |invoice_item|
      InvoiceItem.new(invoice_item)
    end
  end

  def find_all_by_item_id(item_id)
    @array_of_objects.find_all do |item|
      item.item_id == item_id
    end
  end

  def find_all_by_invoice_id(invoice_id)
    @array_of_objects.find_all do |invoice|
      invoice.invoice_id == invoice_id
    end
  end
end
