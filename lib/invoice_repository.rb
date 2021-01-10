require './lib/invoice'
require 'bigdecimal'
require 'bigdecimal/util'
require 'time'
require "csv"

class InvoiceRepository
  attr_reader :filename,
              :parent,
              :invoices

  def initialize(filename, parent)
    @filename = filename
    @parent = parent
    @invoices = Array.new
    generate_invoices(filename)
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def generate_invoices(filename)
    invoices = CSV.open filename, headers: true, header_converters: :symbol
    invoices.each do |row|
      @invoices << Invoice.new(row, self)
    end
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.find do |invoice|
      invoice.id.to_i == id
    end
  end

  def find_all_by_customer_id(customer_id)
   customer_found = []
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
      invoice.status.to_sym == status
    end
  end


    def create(attributes)
      id = @invoices[-1].id.to_i
      id += 1
      id = id.to_i
      attributes[:id] = id
      invoice = Invoice.new(attributes, self)
      @invoices << invoice
    end

  def update(id, attributes)
    update_invoice = find_by_id(id)
    update_invoice.update(attributes) if !attributes[:status].nil?
    update_invoice
  end

  def delete(id)
    delete = find_by_id(id)
    @invoices.delete(delete)
  end
end
