require 'date'
require_relative '../lib/invoice'
require_relative 'repository'

# invoice_repository class
class InvoiceRepository < Repository
  attr_reader :invoices

  def initialize(invoices_data)
    # attributes = csv_parsed_array.map do |invoice|
    #   { id: invoice[0].to_i,
    #     customer_id: invoice[1].to_i,
    #     merchant_id: invoice[2].to_i,
    #     status: invoice[3].to_sym,
    #     created_at: Time.parse(invoice[4]),
    #     updated_at: Time.parse(invoice[5]) }
    # end
    @invoices = create_index(Invoice, invoices_data)
    super(invoices, Invoice)
  end

  def find_all_by_customer_id(customer_id)
    @invoices.values.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @invoices.values.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_created_date(created_date)
    @invoices.values.find_all do |invoice|
      invoice.created_at == created_date
    end
  end

  def find_all_by_status(req_status)
    @invoices.values.find_all do |invoice|
      invoice.status.casecmp(req_status).zero?
    end
  end

  def update(id, attributes)
    return unless @invoices[id]
    @invoices[id].status = attributes[:status].to_sym if attributes[:status]
    @invoices[id].updated_at = Time.now
  end
end
