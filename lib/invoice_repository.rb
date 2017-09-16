require_relative 'invoice'
require_relative 'sales_engine'
require 'csv'


class InvoiceRepository

  attr_reader :all, :invoices

  def initialize(se, invoice_csv)
    @all = []
    @se = se
    CSV.foreach(invoice_csv, headers: true, header_converters: :symbol) do |row|
      all << Invoice.new(self, row)
    end
  end


  def find_by_id(id)
    all.each do |invoice|
      return invoice if invoice.id.to_i == id
    end
    nil
  end


  def find_all_by_customer_id(customer_id)
    customer_id_array = []
    all.each do |invoice|
      if invoice.customer_id.to_i == customer_id
        customer_id_array << invoice
      end
    end
      return customer_id_array
  end

  def find_all_by_merchant_id(merchant_id)
  merchant_id_array = []
  all.each do |invoice|
    if invoice.merchant_id.to_i == merchant_id
      merchant_id_array << invoice
    end
  end
    return merchant_id_array
  end

  def find_all_by_status(status)
  status_array = []
  all.each do |invoice|
    if invoice.status == status
      status_array << invoice
    end
  end
    return status_array
  end

  def inspect
    "#<#{self.class} #{:invoices.size} rows>"
  end
  
end
