require 'csv'
require_relative '../lib/invoice'

class InvoiceRepository
  attr_reader :all

  def initialize(path)
    @all = []
    create_invoices(path)
  end

  def create_invoices(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      invoice = Invoice.new(row)
      @all << invoice
    end
  end

  def find_by_id(id)
    @all.find do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_customer_id(id)
    @all.find_all do |invoice|
      invoice.customer_id == id
    end
  end

  def find_all_by_merchant_id(id)
    @all.find_all do |invoice|
      invoice.merchant_id == id
    end
  end

  def find_all_by_status(status)
    @all.find_all do |invoice|
      invoice.status == status
    end
  end

  def create(attributes)
    new_invoice_id = @all.max_by do |invoice|
      invoice.id
    end
    attributes[:id] = new_invoice_id.id + 1
    invoice = Invoice.new(attributes)
    @all << invoice
    invoice
  end

  # def update(id, attributes)
  #   item = find_by_id(id)
  #   if !item.nil?
  #     item.update(attributes)
  #   end
  # end
end
