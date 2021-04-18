require 'CSV'
require 'time'
require 'invoice'

class InvoiceRepo
  attr_reader :invoices
  def initialize(path, engine)
    @invoices = []
    @engine = engine
    populate_information(path)
  end

  def populate_information(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |data|
      @invoices << Invoice.new(data, self)
    end
  end

  def all
    @invoices
  end

  def add_invoice(invoice)
    @invoices << invoice
  end

  def find_by_id(id)
    @invoices.find do |invoice|
      invoice.id == id
    end
  end

  def create(attributes)
    invoice = Invoice.new(attributes, self)
    max = @invoices.max_by do |invoice|
      invoice.id
    end
    invoice.id = max.id + 1
    add_invoice(invoice)
    invoice
  end

  def find_all_by_customer_id(customer_id)
    @invoices.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @invoices.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    @invoices.find_all do |invoice|
      invoice.status == status
    end
  end

  def update(id, attributes)
    new_invoice = find_by_id(id)
    return if !new_invoice
    new_invoice.status = attributes[:status]
    new_invoice.updated_at = Time.now
    new_invoice
  end

  def delete(id)
    @invoices.delete(find_by_id(id))
  end
end