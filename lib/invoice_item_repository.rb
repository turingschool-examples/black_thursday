require_relative '../lib/invoice_items'
require_relative '../lib/repository'
require 'bigdecimal/util'

class InvoiceItemRepository < Repository

  def initialize(path)
    super(path)
    @array_of_objects = create_invoice_items(@parsed_csv_data)
  end
end
