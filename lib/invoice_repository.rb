require_relative 'invoice'
require 'csv'

class InvoiceRepository
  def initialize(file_path, parent)
    @invoices = []
    @sales_engine = parent
    invoice_data = CSV.open file_path, headers: true, header_converters: :symbol, converters: :numeric
    parse(invoice_data)
  end

  def parse(invoice_data)
    invoice_data.each do |row|
      @invoices << Invoice.new(row.to_hash, self)
    end
  end

  def all
    return @invoices
  end

  def find_by_id(id)
    @invoices.find do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_customer_id(customer_id)
  @invoices.find_all do |invoice|
    invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @invoices.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    @invoices.find_all do |invoice|
      invoice.status == status
    end
  end

  def find_merchant(merchant_id)
    @sales_engine.find_merchant_by_merchant_id(merchant_id)
  end

  def invoices_created_each_weekday
    invoices_grouped_by_weekday = @invoices.group_by do |invoice|
      invoice.weekday
    end
    invoices_grouped_by_weekday.transform_values do |invoices|
      invoices.count
    end
  end
end
