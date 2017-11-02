require 'csv'
require_relative '../lib/invoice'

class InvoiceRepository

  attr_reader :invoices, :parent

  def initialize(invoice_file, parent)
    @invoices      = invoice_file.map {|invoice| Invoice.new(invoice, self)}
    @parent        = parent
  end

  def find_by_id(id)
    invoices.find do |invoice|
      invoice.id == id.to_s
    end
  end

  def all
    return invoices
  end

  def count
    invoices.count
  end

  def find_all_by_customer_id(customer_id)
    invoices.find_all do |invoice|
      invoice.customer_id == customer_id.to_s
    end
  end

  def find_all_by_merchant_id(merchant_id)
    invoices.find_all do |invoice|
      invoice.merchant_id == merchant_id.to_s
    end
  end

  def find_all_by_status(status)
    invoices.find_all do |invoice|
      invoice.status == status.to_s
    end
  end



end

# find_all_by_customer_id - returns either [] or one or more matches which have a matching customer ID
# find_all_by_merchant_id - returns either [] or one or more matches which have a matching merchant ID
# find_all_by_status - returns either [] or one or more matches which have a matching status
