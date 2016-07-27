require "csv"
require_relative "invoice"

class InvoiceRepo

  def initialize(csv_filepath, parent = nil)
    contents = CSV.open csv_filepath, headers: true, header_converters: :symbol
    @invoice_objects = contents.map do |row|
      Invoice.new(row)
    end
    @parent = parent
  end

  def all
    @invoice_objects
  end

  def find_by_id(invoice_id)
    invoice_id = invoice_id.to_i
    invoice = find_invoice_id(invoice_id)
    if invoice != nil
      invoice
    else
      nil
    end
  end

  def find_invoice_id(invoice_id)
    @invoice_objects.detect do |invoice|
      invoice.id == invoice_id
    end
  end

  def find_all_by_customer_id(customer_id)
    @invoice_objects.select do |invoice|
      invoice.customer_id == customer_id.to_i
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @invoice_objects.select do |invoice|
      invoice.merchant_id == merchant_id.to_i
    end
  end

  def find_all_by_status(status)
    @invoice_objects.select do |invoice|
      invoice.status == status
    end
  end

end
