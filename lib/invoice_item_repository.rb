require_relative '../lib/invoice_items'
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

end
