require_relative "invoice"
require "csv"

class InvoiceRepository
  attr_reader :invoices

  def initialize(invoice_file)
    @invoices = []
    invoices_from_csv(invoice_file)
  end

  def invoices_from_csv(invoice_file)
    CSV.foreach(invoice_file, headers: true, header_converters: :symbol) do |row|
      @invoices << Invoice.new(row)
    end
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.find {|invoice| invoice.id == id}
  end

  def find_by_customer_id(customer_id)
    @invoices.find do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @invoices.find_all {|invoice| invoice.merchant_id == merchant_id}
  end

  def find_all_by_status(status)
    @invoices.find_all {|invoice| invoice.status == status}
  end
end
