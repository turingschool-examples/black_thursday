require 'csv'
require_relative 'invoice'

class InvoiceRepository
  attr_reader :path,
              :invoices

  def initialize(path, sales_engine)
    @path = path
    @invoices = []
    load_path(path)
  end

  def load_path(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |data|
      @invoices << Invoice.new(data, self)
    end
  end

  def all
    @invoices
  end

  def find_by_id(id)
    @invoices.find do |invoice|
      invoice.id == id.to_i
    end
  end

  def find_all_by_customer_id(customer_id)
    @invoices.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @invoices.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    @invoices.find_all do |invoice|
      invoice.status == status.to_s
    end
  end

  def create_new_id
    @invoices.map do |invoice|
      invoice.id
    end.max + 1
  end

  def create(attributes)
    attributes[:id] = create_new_id
    attributes[:created_at] = Time.now.strftime('%F')
    attributes[:updated_at] = Time.now.strftime('%F')
    @invoices << Invoice.new(attributes, self)
  end

  def update(id, attributes)
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end
end
