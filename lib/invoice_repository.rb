require 'csv'
require_relative './invoice'
require 'pry'

class InvoiceRepository
    attr_reader :invoices

  def initialize
    @invoices = []
  end

  def create(attributes)
    unless invoices.empty?
    attributes[:id] = all.max do |invoice|
      invoice.id
      end.id + 1
    end
    new_invoice = Invoice.new(attributes)
    @invoices << new_invoice
    new_invoice
  end

  def parse_data(file)
    rows = CSV.open file, headers: true, header_converters: :symbol
      rows.each do |row|
        new_item = Invoice.new(row.to_h)
        @invoices << new_item
      end  
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
    @invoices.select do |invoice|
        invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @invoices.select do |invoice|
        invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    @invoices.select do |invoice|
        invoice.status == status.to_sym
    end
  end

  def update(id, attributes)
    if updated_invoice = find_by_id(id)
      updated_invoice.status = attributes[:status]
      attributes[:updated_at] = Time.now
    end
  end

  def delete(id)
    @invoices.delete_if { |invoice| invoice.id == id }
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end
end