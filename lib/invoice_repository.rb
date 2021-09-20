require 'csv'
require './lib/sales_engine'
require './lib/invoice'

class InvoiceRepository
  attr_reader :all

  def initialize(invoice_path)
    @all = (
      invoice_objects = []
      CSV.foreach(invoice_path, headers: true, header_converters: :symbol) do |row|
        invoice_objects << Invoice.new(row)
      end
      invoice_objects)
  end

  def find_by_id(id)
    if (@all.any? do |invoice|
      invoice.id == id
    end) == true
      @all.find do |invoice|
        invoice.id == id
      end
    else
      nil
    end
  end

  def find_all_by_customer_id(customer_id)
    if (@all.any? do |invoice|
      invoice.customer_id == customer_id
    end) == true
      @all.find_all do |invoice|
        invoice.customer_id == customer_id
      end
    else
      []
    end
  end

end
