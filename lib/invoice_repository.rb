require 'csv'
require_relative '../lib/invoice.rb'
require_relative '../lib/repo_method_helper.rb'
require 'pry'

class InvoiceRepository
  attr_reader :invoices
  include RepoMethodHelper

  def initialize(invoice_location)
    @invoice_location = invoice_location
    @invoices = []
    from_sales_engine
  end

  def from_sales_engine
    CSV.foreach(@invoice_location, headers: true, header_converters: :symbol) do |row|
      @invoices << Invoice.new(row)
    end
  end

  def all
    @invoices
  end

  def find_all_by_customer_id(customer_id)
    all.find_all do |each|
      each.customer_id == customer_id
    end
  end

  def inspect
    "#<#{self.InvoiceRepository} #{@invoices.size} rows>"
  end
end
