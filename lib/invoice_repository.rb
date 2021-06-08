require 'CSV'
require_relative 'invoice'

class InvoiceRepository
  attr_reader :file_path, :all, :invoices, :id

  def initialize (file_path, engine)
    @file_path = file_path
    @engine = engine
    @invoices = []
  end

  def create_repo
    CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
      invoice = Invoice.new(row, self)
      @invoices << invoice
    end
    self
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
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

  def find_all_by_merchant_id(id)
    invoices.find_all do |invoice|
      invoice.merchant_id == id
    end
  end

  def find_all_by_status(status)
    invoices.find_all do |invoice|
      invoice.status == status
    end
  end

  def create(attributes)
    invoice_id = invoices.max { |invoice| invoice.id }
    attributes[:id] = invoice_id.id + 1
    attributes[:created_at] = Time.now.strftime("%Y-%m-%d")
    attributes[:updated_at] = Time.now.strftime("%Y-%m-%d")
    @invoices << Invoice.new(attributes, self)
  end

  def update(id, attributes)
    invoice_by_id = find_by_id(id)
    if invoice_by_id != nil
      invoice_by_id.change_status(attributes[:status])
    end
  end

  def delete(id)
    chopping_block = invoices.index { |invoice| invoice.id == id }
    if chopping_block != nil
      invoices.delete_at(chopping_block)
    end
  end

end
