require_relative './invoice'
require_relative './repository'
require 'time'

# holds invoices and allows for basic invoice creation and retrieval
class InvoiceRepository
  include Repository

  attr_reader :repository

  def initialize(invoices)
    invoice_array = []
    @repository = {}
    invoices.each { |invoice| invoice_array << Invoice.new(to_invoice(invoice))}
    invoice_array.each do |invoice|
      if invoice.nil?
      else
        @repository[invoice.id] = invoice
      end
    end
  end

  def to_invoice(invoice)
    invoice_hash = {}
    invoice.each do |line|
      invoice_hash[line[0]] = line[1]
    end
    invoice_hash
  end

  def find_all_by_customer_id(input)
    @repository.values.find_all do |invoice|
      invoice.customer_id == input
    end
  end

  def find_all_by_status(input)
    @repository.values.find_all do |invoice|
      invoice.status == input
    end
  end

  def create(attributes)
    attributes[:id] = (find_highest_id + 1)
    if (attributes[:created_at] = Time.now.to_s)
    else
      attributes[:created_at] = attributes[:created_at].to_s
    end
    attributes[:updated_at] = attributes[:updated_at].to_s
    invoice = Invoice.new(attributes)
    @repository[invoice.id] = invoice
  end
end
