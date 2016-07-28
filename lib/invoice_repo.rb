require "csv"
require_relative "../lib/invoice"

class InvoiceRepo

  def initialize(csv_filepath, parent = nil)
    contents = CSV.open csv_filepath, headers: true, header_converters: :symbol
    @invoice_objects = contents.map do |row|
      Invoice.new(row, self)
    end
    @parent = parent
  end

  def all
    @invoice_objects
  end

  def find_by_id(invoice_id)
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

  def find_merchant_by_id(merchant_id)
    @parent.find_merchant_by_id(merchant_id)
  end

end
