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

  def find_all_by_status(status)
    all.find_all do |each|
      each.status == status.to_sym
    end
  end

  def create(attributes)
    attributes[:id] = create_id
    attributes[:created_at] = Time.now.to_s
    attributes[:updated_at] = Time.now.to_s
    created = Invoice.new(attributes)
    @invoices << created
    created
  end

  def update(id, attributes)
    find_by_id(id).status = attributes[:status] unless attributes[:status].nil?
    find_by_id(id).updated_at = Time.now unless find_by_id(id).nil?
  end


  def inspect
    "#<#{self.InvoiceRepository} #{@invoices.size} rows>"
  end
end
