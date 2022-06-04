require 'CSV'
require "BigDecimal"
require_relative'./invoice.rb'

class InvoiceRepository
  def initialize(invoice_path)
    @invoice_path = invoice_path
    @all_invoices = []

    CSV.foreach(@invoice_path, headers: true, header_converters: :symbol) do |row|
    @all_invoices << Invoice.new({
      :id => row[:id],
      :customer_id => row[:customer_id],
      :status => row[:status],
      :created_at => row[:created_at],
      :updated_at => row[:updated_at],
      :merchant_id => row[:merchant_id]})
    end
  end
end
