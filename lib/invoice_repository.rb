require_relative '../lib/invoice'
require_relative 'repository'

# invoice_repository class
class InvoiceRepository < Repository
  attr_reader :invoices

  def initialize(csv_parsed_array)
    csv_parsed_array.shift
    attributes = csv_parsed_array.map do |invoice|
      { id: invoice[0].to_i,
        customer_id: invoice[1].to_i,
        merchant_id: invoice[2].to_i,
        status: invoice[3],
        created_at: invoice[4],
        updated_at: invoice[5] }
    end
    @invoices = create_index(Invoice, attributes)
    super(invoices, Invoice)
  end
end
