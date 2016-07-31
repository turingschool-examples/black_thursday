# require_relative "../lib/merchant"
require_relative "../lib/invoice"
require "csv"
require 'pry'

class InvoiceRepository
attr_reader :all

  def initialize(data_path, sales_engine=nil)
    @sales_engine = sales_engine
    @all = []
    csv_loader(data_path)
    invoice_maker
  end

  def csv_loader(data_path)
    @csv = CSV.open data_path, headers:true, header_converters: :symbol
  end

  def invoice_maker
    @all = @csv.map do |row|
      Invoice.new(row, self)
    end
  end

  def find_by_id(invoice_id)
    @all.find do |instance|
      instance.id == invoice_id.to_i
    end
  end

  def find_all_by_customer_id(customer_id_input)
    @all.find_all do |instance|
      instance.customer_id == customer_id_input
    end
  end

  def find_all_by_merchant_id(merchant_id_input)
    @all.find_all do |instance|
      instance.merchant_id == merchant_id_input
    end
  end

  def find_all_by_status(status_input)
    @all.find_all do |instance|
      instance.status == status_input
    end
  end

  def inspect
  end



end
