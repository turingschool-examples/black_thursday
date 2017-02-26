require_relative 'merchant'
require_relative 'sales_engine'
require_relative 'item_repository'
require_relative 'item'
require_relative 'csv_parser'
require_relative 'merchant_repository'
require 'pry'

class InvoiceRepository

  attr_reader :all
  
  def initialize(invoice_data, parent)
    @all = invoice_data.map { |raw_invoice| Invoice.new(raw_invoice, self)}
  end

end