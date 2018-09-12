require_relative './invoice'
require_relative './repository'
require 'time'

class InvoiceRepository < Repository
  def initialize(filepath)
    super()
    load_items(filepath)
  end

  def load_items(filepath)
    CSV.foreach(filepath, headers:  true, header_converters: :symbol ) do |datum|
      @data << Invoice.new(datum)
    end
  end

  def find_by_id(id)
    @data.find do |datum|
      datum.id == id
    end
  end

  def find_all_by_customer_id(customer_id)
    all_invoices = @data.find_all do |datum|
      datum.customer_id == customer_id
      end
    return all_invoices
  end

  def find_all_by_status(status)
    all_invoices = @data.find_all do |datum|
      datum.status.include?(status)
      end
    return all_invoices
  end

  def create(new_invoice)
    highest_id = @data.max_by do |datum|
      datum.id
    end.id
    new_invoice_id = highest_id += 1
    new_invoice[:id] = new_invoice_id
    new_invoice = Invoice.new(new_invoice)

    @data << new_invoice
    return new_invoice
  end

  def update(id, attribute)
    invoice = find_by_id(id)
    return if invoice.nil?
    attribute.each do |key, value|
      invoice.status = value if key == :status
    end
    current_time = Time.now + 1
    invoice.updated_at = current_time.to_s
  end

  def delete(id)
    invoice = find_by_id(id)
    @data.delete(invoice)
  end
end
