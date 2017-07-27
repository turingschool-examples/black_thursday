require 'pry'
require 'csv'
require 'time'
require_relative '../lib/invoice'
require_relative '../lib/file_opener'

class InvoiceRepository
  include FileOpener
  attr_reader :all,
              :sales_engine

  def initialize(invoice_data, se)
    @sales_engine = se
    @invoice_data = open_csv(invoice_data)
    @all          = @invoice_data.map do |row|
      Invoice.new(row, self)
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def find_by_id(id)
    @all.find do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_customer_id(customer_id)
    @all.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    @all.find_all do |invoice|
      (/#{status}/i) =~ invoice.status
    end
  end

end
