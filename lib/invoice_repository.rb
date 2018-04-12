require_relative '../lib/invoice'
require_relative 'repository'

# invoice_repository class
class InvoiceRepository < Repository
  attr_reader :invoices

  def initialize(csv_parsed_array)
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

  def find_all_by_day_of_week(weekday)
    weekday = Date.parse(weekday).cwday
    @invoices.values.find_all do |invoice|
      Date.parse(invoice.created_at).cwday == weekday
    end
  end

  def find_all_by_status(req_status)
    @invoices.values.find_all do |invoice|
      invoice.status.casecmp(req_status).zero?
    end
  end

  def update(id, attributes)
    return unless @invoices[id]
    @invoices[id].status = attributes[:status] if attributes[:status]
    @invoices[id].updated_at = Time.now
  end
end
