require_relative 'invoice'
require 'csv'

class InvoiceRepository

  attr_reader :invoices,
              :parent

  def initialize(file_path, parent = nil)
    @invoices = []
    load_csv(file_path)
    @parent = parent
  end

  def load_csv(file_path)
    CSV.foreach(file_path, headers: true, header_converters: :symbol, converters: :numeric ) do |item|
      invoices << Invoice.new(item.to_h, self)
    end
  end

  def all
    invoices
  end

  def find_by_id(id)
    invoices.find do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_customer_id(id)
    invoices.find_all do |invoice|
      invoice.customer_id == id
    end
  end









end
