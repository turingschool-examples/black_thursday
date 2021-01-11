require_relative 'invoice'
require_relative 'repository_module'
require 'bigdecimal'
require 'bigdecimal/util'
require 'time'
require "csv"

class InvoiceRepository
  include Repository
  attr_reader :filename,
              :parent,
              :collection

  def initialize(filename, parent)
    @filename = filename
    @parent = parent
    @collection = Array.new
    generate_invoices(filename)
  end

  def generate_invoices(filename)
    invoices = CSV.open filename, headers: true, header_converters: :symbol
    invoices.each do |row|
      @collection << Invoice.new(row, self)
    end
  end

  def find_all_by_customer_id(customer_id)
   customer_found = []
    @collection.find_all do |invoice|
     invoice.customer_id.to_i == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @collection.find_all do |invoice|
     invoice.merchant_id.to_i == merchant_id
    end
  end

  def find_all_by_status(status)
    @collection.find_all do |invoice|
      invoice.status.to_sym == status
    end
  end

  def create(attributes)
    attributes[:id] = highest_id_plus_one
    invoice = Invoice.new(attributes, self)
    @collection << invoice
  end

  def update(id, attributes)
    update_invoice = find_by_id(id)
    update_invoice.update(attributes) if !attributes[:status].nil?
    update_invoice
  end
end
