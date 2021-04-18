require_relative './invoices'
require 'time'
require 'csv'
require 'bigdecimal'

class InvoiceRepo
  attr_reader :invoice_list

  def initialize(csv_files, engine)
    @invoice_list = invoice_instances(csv_files)
    @engine    = engine
  end

  def invoice_instances(csv_files)
    invoices = CSV.open(csv_files, headers: true,
    header_converters: :symbol)

    @invoice_list = invoices.map do |invoice|
      Invoice.new(invoice, self)
    end
  end

  def all
    @invoice_list
  end

  def find_by_id(id)
    @invoice_list.find do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_customer_id(id)
    @invoice_list.find_all do |invoice|
      invoice.customer_id == id
    end
  end

  def find_all_by_merchant_id(id)
    @invoice_list.find_all do |invoice|
      invoice.merchant_id == id
    end
  end

  def find_all_by_status(status)
    @invoice_list.find_all do |invoice|
      invoice.status == status
    end
  end

  def create(attributes)
    new_invoice = Invoice.new(attributes, self)
    find_max_id = @invoice_list.max_by do |invoice|
      invoice.id
    end
    new_invoice.id = (find_max_id.id + 1)
    invoice_list << new_invoice
  end

  def update(id, attributes)
    invoice = find_by_id(id)
    if !invoice.nil?
      invoice.status = attributes[:status] unless attributes[:status].nil?
      invoice.updated_at = Time.now
    end
    invoice
  end

  def delete(id)
    invoice = find_by_id(id)
    if invoice_exists?(id)
      @invoice_list.delete(invoice)
    end
  end

  def invoice_exists?(id)
    invoice = find_by_id(id)
    invoice != nil
  end
end
