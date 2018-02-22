# frozen_string_literal: true

require 'csv'
require_relative 'invoice'

# Defines Invoice Repository
class InvoiceRepository
  def initialize(filename, sales_engine)
    @invoices = []
    @sales_engine = sales_engine
    load_invoices filename
  end

  def load_invoices(filename)
    CSV.foreach(
      filename,
      headers: true,
      header_converters: :symbol
    ) do |data|
      @invoices << Invoice.new(data)
    end
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.find do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_customer_id(id)
    @invoices.select do |invoice|
      invoice.customer_id == id
    end
  end

  def find_all_by_merchant_id(id)
    @invoices.select do |invoice|
      invoice.merchant_id == id
    end
  end

  def find_all_by_status(status)
    @invoices.select do |invoice|
      invoice.status == status
    end
  end
end
