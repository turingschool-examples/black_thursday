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
        status: invoice[3].to_sym,
        created_at: invoice[4],
        updated_at: invoice[5] }
    end
    @invoices = create_index(Invoice, attributes)
    super(invoices, Invoice)
  end

  def find_all_by_customer_id(customer_id)
    @invoices.values.map do |invoice|
      invoice if invoice.customer_id == customer_id
    end.compact
  end

  def find_all_by_merchant_id(merchant_id)
    @invoices.values.map do |invoice|
      invoice if invoice.merchant_id == merchant_id
    end.compact
  end

  def find_all_by_status(req_status)
    @invoices.values.map do |invoice|
      invoice if invoice.status.casecmp(req_status).zero?
    end.compact
  end

  def update(id, attributes)
    if @invoices[id]
      @invoices[id].name = attributes[:name] if attributes[:name]
      @invoices[id].description = attributes[:description] if attributes[:description]
      @invoices[id].updated_at = Time.now
    end
  end
end
