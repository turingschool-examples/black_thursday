require_relative 'invoice'
require 'csv'

class InvoiceRepository
  attr_reader :engine, :contents

  def initialize(csvfile, engine)
    @engine   = engine
    @contents = create_hash_of_invoices(csvfile)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def create_hash_of_invoices(csvfile)
    contents = CSV.open csvfile, headers: true, header_converters: :symbol
    all_invoices = {}
    contents.each do |row|
      all_invoices[row[:id]] = Invoice.new(row, self)
    end
    all_invoices
  end

  def all
    @contents.values
  end

  def find_by_id(id)
    @contents[id.to_s]
  end

  def find_all_by_customer_id(customer_id)
    content_array = all
    content_array.find_all do |invoice|
      if invoice.customer_id == customer_id.to_s
        invoice
      end
    end
  end

  def find_all_by_merchant_id(merchant_id)
    content_array = all
    content_array.find_all do |invoice|
      if invoice.merchant_id == merchant_id.to_s
        invoice
      end
    end
  end

  def find_all_by_status(status)
    content_array = all
    content_array.find_all do |invoice|
      if invoice.status == status
        return invoice
      end
    end
  end

end
