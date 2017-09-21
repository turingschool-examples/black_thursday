require_relative 'invoice'
require_relative 'sales_engine'
require 'csv'

class InvoiceRepository

  attr_reader :all, :invoices, :sales_engine

  def initialize(sales_engine, invoice_csv)
    @all = []
    @sales_engine = sales_engine
    CSV.foreach(invoice_csv, headers: true, header_converters: :symbol) do |row|
      all << Invoice.new(self, row)
    end
  end

  def find_by_id(id)
    all.each do |invoice|
      return invoice if invoice.id == id
    end
    nil
  end

  def find_all_by_customer_id(customer_id)
    all.select {|invoice| invoice.customer_id.to_i == customer_id}
  end

  def find_all_by_merchant_id(merchant_id)
    all.select {|invoice| invoice.merchant_id.to_i == merchant_id}
  end

  def find_all_by_status(status)
    all.select {|invoice| invoice.status == status}
  end

  def inspect
    "#<#{self.class} #{:invoices.size} rows>"
  end

end
