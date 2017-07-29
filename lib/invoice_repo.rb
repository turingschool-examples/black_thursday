require_relative 'invoice'
require 'csv'
require 'pry'

class InvoiceRepository
  attr_reader :engine, :contents

  def initialize(csvfile, engine)
    @engine   = engine
    @contents = create_hash_of_invoices(csvfile)
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
    @contents.values
  end

  def find_by_id(invoice_id)
    @contents[invoice_id.to_s]
  end

  def find_all_by_customer_id(customer_id)
    all.find_all do |invoice|
      if invoice.customer_id == customer_id.to_s
         invoice
      end
    end
  end

  def find_all_by_merchant_id(merchant_id)
    all.find_all do |invoice|
      if invoice.merchant_id == merchant_id.to_s
        invoice
      end
    end
  end

  def find_all_by_status(status)
    all.find_all do |invoice|
      if invoice.status == status
         invoice
      end
    end
  end

end
