require 'CSV'
require 'time'
require 'invoice'
require_relative 'findable'

class InvoiceRepo
  include Findable
  attr_reader :invoices,
            :engine

  def initialize(path, engine)
    @invoices = []
    @engine = engine
    populate_information(path)
  end

  def populate_information(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |data|
      @invoices << Invoice.new(data, self)
    end
  end

  def all
    @invoices
  end

  def add_invoice(invoice)
    @invoices << invoice
  end

  def create(attributes)
    invoice = Invoice.new(attributes, self)
    max = @invoices.max_by do |invoice|
      invoice.id
    end
    invoice.update_id(max.id)
    add_invoice(invoice)
    invoice
  end

  def update(id, attributes)
    invoice = find_by_id(id, @invoices)
    return if !invoice
    invoice.update_all(attributes)
  end

  def delete(id)
    @invoices.delete(find_by_id(id, @invoices))
  end

  def invoice_count_per_merchant
    merchant_invoices = {}
    @invoices.each do |invoice|
      merchant_invoices[invoice.merchant_id] = find_all_by_merchant_id(invoice.merchant_id, @invoices).length
    end
      merchant_invoices
  end

  def find_all_by_day_created(day)
    @invoices.find_all do |invoice|
      invoice.created_at.strftime("%A") == day
    end
  end

  def invoice_count_per_day
    day_count = {}
    @invoices.each do |invoice|
      day_count[invoice.created_at.strftime("%A")] = find_all_by_day_created(invoice.created_at.strftime("%A")).length
    end
      day_count
  end

  def find_all_by_date(date) #spec
    @invoices.find_all do |invoice|
      invoice.created_at == date
    end
  end

  def find_all_pending
    @invoices.find_all do |invoice|
      invoice.status != "success"
    end
  end

  def invoices_by_merchant
    @invoices.group_by do |invoice|
      invoice.merchant_id
    end.compact
  end
end
