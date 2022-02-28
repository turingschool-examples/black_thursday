# item_repository
require 'pry'
class InvoiceRepository
  attr_reader :invoices

  def initialize(invoices)
    @invoices = invoices
  end

  def all
    @invoices
  end

  def find_by_id(invoice_id)
    @invoices.find { |invoice| invoice.id == invoice_id }
  end

  def find_all_by_customer_id(customer_id)
    @invoices.find_all { |invoice| invoice.customer_id == customer_id }
  end

  def find_all_by_merchant_id(merchant_id)
    @invoices.find_all { |invoice| invoice.merchant_id == merchant_id }
  end

  def find_all_by_status(status)
    @invoices.find_all { |invoice| invoice.status == status }
  end

  def create(attributes)
    @invoices.sort_by { |invoice| invoice.id }
    last_id = @invoices.last.id
    attributes[:id] = (last_id += 1)
    @invoices << Invoice.new(attributes)
  end

  def update(id, attributes)
    invoice = find_by_id(id)
    attributes.map do |key, value|
      invoice.customer_id = value if key == :customer_id
      invoice.merchant_id = value if key == :merchant_id
      invoice.status = value if key == :status
      invoice.updated_at = Time.now
    end
  end
end
