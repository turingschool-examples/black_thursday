require_relative "invoice"
require "csv"

class InvoiceRepository
  attr_reader :invoices, :sales_engine

  def initialize(invoice_file, sales_engine)
    @invoices = []
    invoices_from_csv(invoice_file)
    @sales_engine = sales_engine
  end

  def invoices_from_csv(invoice_file)
    CSV.foreach(invoice_file, headers: true, header_converters: :symbol) do |row|
      @invoices << Invoice.new(row, self)
    end
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.find {|invoice| invoice.id == id}
  end

  def find_all_by_customer_id(customer_id)
    @invoices.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @invoices.find_all {|invoice| invoice.merchant_id == merchant_id}
  end

  def find_all_by_status(status)
    @invoices.find_all {|invoice| invoice.status == status}
  end

  def invoice_merchants(merchant_id)
    sales_engine.find_invoice_for_merchants(merchant_id)
  end

  def inspect
    "#{self.class} #{invoices.size} rows"
  end
end
