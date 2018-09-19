require_relative 'helper'

class InvoiceRepository
  attr_reader :invoices

  def initialize(invoice_path)
    @invoices = []
    make_invoices(invoice_path)
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.find do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_customer_id(customer_id)
    @invoices.find_all do |invoice|
      invoice.customer_id.to_i == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @invoices.find_all do |invoice|
      invoice.merchant_id.to_i == merchant_id
    end
  end

  def find_all_by_status(status)
    @invoices.find_all do |invoice|
      invoice.status == status
    end
  end

  def create(attributes)
    attributes[:id] = @invoices[-1].id += 1
    new_invoice = Invoice.new(attributes)
    @invoices << new_invoice
    new_invoice
  end

  def update(id, attribute)
    invoice = find_by_id(id)
    return if invoice.nil?
    updated_status = attribute[:status]
    invoice.status = updated_status
    invoice
  end

  def delete(id)
    find_invoice = find_by_id(id)
    @invoices.delete_if do |invoice|
     invoice == find_invoice
    end
  end

  def make_invoices(invoice_path)
    CSV.foreach(invoice_path, headers: true, header_converters: :symbol) do |row|
      @invoices << Invoice.new(row)
    end
  end
end
