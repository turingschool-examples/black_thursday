require 'csv'
require_relative 'invoice'

class InvoiceRepository
  attr_reader :all

  def initialize(file_path)
    @file_path = file_path
    @all = []
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      @all << Invoice.new({:id => row[:id], :customer_id => row[:customer_id], :merchant_id => row[:merchant_id], :status => row[:status], :created_at => row[:created_at], :updated_at => row[:updated_at]})
    end
  end

  def find_by_id(invoice_id)
    @all.find { |invoice| invoice.id.to_i == invoice_id}
  end

  def find_all_by_customer_id(cust_id)
    @all.find_all {|invoice| invoice.customer_id.to_i == cust_id}
  end

  def find_all_by_merchant_id(merchant_id)
    @all.find_all {|invoice| invoice.merchant_id == merchant_id}
  end

  def find_all_by_status(status)
    @all.find_all {|invoice| invoice.status == status}
  end
end
