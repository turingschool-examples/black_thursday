require 'CSV'
require "BigDecimal"
require_relative'./invoice.rb'
class InvoiceRepository
  attr_reader :all

  def initialize(invoice_path)
    @invoice_path = invoice_path
    @all = []

    CSV.foreach(@invoice_path, headers: true, header_converters: :symbol) do |row|
    @all << Invoice.new({
      :id => row[:id],
      :customer_id => row[:customer_id],
      :status => row[:status],
      :created_at => row[:created_at],
      :updated_at => row[:updated_at],
      :merchant_id => row[:merchant_id]})
    end
  end

  def find_by_id(id)
    @all.find do |invoice|
      invoice.id.to_i == id
    end
  end
end
