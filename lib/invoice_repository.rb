require 'csv'
require_relative 'invoice'
require 'pry'

class InvoiceRepository

  attr_reader :engine

  def initialize(filepath, parent = nil)
    @invoices    = []
    @engine   = parent
    load_items(filepath)
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def load_items(filepath)
    CSV.foreach(filepath, headers: true, header_converters: :symbol) do |data|
      @invoices << Invoice.new(data, self)
    end
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.find { |invoice| invoice.id == id }
  end

  def find_all_by_customer_id(id)
    @invoices.find_all { |invoice| invoice.customer_id == id }
  end

  def find_all_by_merchant_id(id)
    @invoices.find_all { |invoice| invoice.merchant_id == id }
  end

  def find_all_by_status(status)
    @invoices.find_all { |invoice| invoice.status == status }
  end

  def find_merchant_by_merchant_id(id)
    engine.find_merchant_by_merchant_id(id)
  end

end
