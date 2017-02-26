require 'csv'
require_relative 'invoice'

class InvoiceRepository

  attr_reader :all, :engine
  def initialize(invoice_csv_data, engine ="")
    @all = []
    @engine = engine
    create_invoice_instances(invoice_csv_data)
  end

  def create_invoice_instances(data)
    CSV.foreach(data, headers: true, header_converters: :symbol) do |row|
      all << Invoice.new({id: row[:id], customer_id: row[:customer_id], merchant_id: row[:merchant_id], status: row[:status], created_at: row[:created_at], updated_at: row[:updated_at]}, self)
    end
  end

  def find_by_id(id_num)
    all.find { |invoice| invoice.id == id_num }
  end

  def find_all_by_customer_id(customer_id_num)
    all.select { |invoice| invoice.customer_id == customer_id_num}
  end

  def find_all_by_merchant_id(merchant_id_num)
    all.select { |invoice| invoice.merchant_id == merchant_id_num }
  end
  
  def find_all_by_status(status_entry)
    all.select { |invoice| invoice.status == status_entry.to_sym}
  end

  def inspect
  "#<#{self.class} #{@merchants.size} rows>"
  end

end
