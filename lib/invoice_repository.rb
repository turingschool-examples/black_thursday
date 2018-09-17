require_relative './invoice'
require 'time'
require 'pry'
require 'CSV'

class InvoiceRepository
  attr_reader     :invoices

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

  def make_invoices(invoice_path)
   CSV.foreach(invoice_path, headers: true, header_converters: :symbol) do |row|
      @invoices << Invoice.new(row)
    end
  end
end
