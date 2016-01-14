require 'pry'
require 'csv'
require 'set'
require_relative 'invoice'

class InvoiceRepository

  def initialize(invoices)
    parse_invoices(invoices)
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def parse_invoices(invoices)
    @invoice_array = []
    invoices.each do |row|
      id          = row[:id]
      customer_id = row[:customer_id]
      merchant_id = row[:merchant_id]
      status      = row[:status]
      created_at  = row[:created_at]
      updated_at  = row[:updated_at]

      @invoice_array << Invoice.new({:id          => id,
                                     :customer_id => customer_id,
                                     :merchant_id => merchant_id,
                                     :status      => status,
                                     :created_at  => created_at,
                                     :updated_at  => updated_at})
    end
  end

  def all
    @invoice_array
  end

  def find_by_id(invoice_id)
    if id_object = @invoice_array.find { |i| i.id == invoice_id}
      id_object
    else
      nil
    end
  end

  def find_all_by_customer_id(customer_id)
    @invoice_array.select do |invoice|
      if invoice.customer_id == customer_id
        invoice
      end
    end
  end

  def find_all_by_merchant_id(merchant_id)
    invoice_array.select do |invoice|
      if invoice.merchant_id == merchant_id
        invoice
      end
    end
  end

  def find_all_by_status(status)
    invoice_array.select do |invoice|
      if invoice.status == status
        invoice
      end
    end
  end

end

if __FILE__ == $0

end
