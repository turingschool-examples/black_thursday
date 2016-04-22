require_relative 'invoice'

class InvoiceRepository
  attr_reader :invoices
  attr_accessor :merchant

  def initialize(invoices_data)
    @invoices = create_invoices(invoices_data)
  end

  def create_invoices(invoices_data)
    invoices_data.map do |invoice|
      Invoice.new(invoice)
    end
  end

  def all
    invoices
  end

  def find_by_id(invoice_id)
    invoices.find do |invoice|
      invoice.id == invoice_id
    end
  end

  def find_all_by_customer_id(customer_id)
    invoices.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    invoices.find_all do |invoice|
      invoice.merchant_id == merchant_id.to_i
      # require 'pry' ; binding.pry
    end
  end

  def find_all_by_status(status)
    invoices.find_all do |invoice|
      invoice.status == status.to_s
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

end
