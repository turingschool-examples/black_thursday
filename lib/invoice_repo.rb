require_relative 'invoice'
require 'csv'
require 'pry'

class InvoiceRepository
  attr_reader :engine, :invoices

  def initialize(csvfile, engine)
    @engine   = engine
    @invoices = create_hash_of_invoices(csvfile)
  end

  def create_hash_of_invoices(csvfile)
    all_items = {}
    csvfile.each do |row|
      all_items[row[:id]] = Invoice.new(row, self)
    end
    all_items
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def all
    @invoices.values
  end

  def find_by_id(invoice_id)
    @invoices[invoice_id.to_s]
  end

  def find_merchant_vendor(merchant_id)
    @engine.find_merchant_by_id(merchant_id)
  end

  def find_all_by_customer_id(customer_id)
    array_of_matching_invoices = []
    all.find_all do |invoice|
      if invoice.customer_id == customer_id
        array_of_matching_invoices << invoice
      end
    end
  end

  def find_all_by_merchant_id(merchant_id)
    array_of_matching_invoices = []
    all.find_all do |invoice|
      if invoice.merchant_id == merchant_id
        array_of_matching_invoices << invoice
      end
    end
  end

  def find_all_by_status(status)
    all.find_all do |invoice|
      if invoice.status == status.to_sym
         invoice
      end
    end
  end

end
