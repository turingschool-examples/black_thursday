require 'CSV'
require 'time'
require 'invoice'
require_relative 'findable'

include Findable
class InvoiceRepo
  attr_reader :invoices

  def initialize(path, engine)
    @invoices = []
    @engine = engine
    populate_information(path)
  end

  def populate_information(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |data|
      @invoices << Invoice.new(data)
    end
  end

  def all
    @invoices
  end

  def add_invoice(invoice)
    @invoices << invoice
  end

  def create(attributes)
    invoice = Invoice.new(attributes)
    max = @invoices.max_by do |invoice|
      invoice.id
    end
    invoice.id = max.id + 1
    add_invoice(invoice)
    invoice
  end

  def update(id, attributes)
    new_invoice = find_by_id(id)
    return if !new_invoice
    new_invoice.status = attributes[:status]
    new_invoice.updated_at = Time.now
    new_invoice
  end

  def delete(id)
    @invoices.delete(find_by_id(id))
  end
end
