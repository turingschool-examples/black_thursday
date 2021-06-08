require 'csv'
require 'bigdecimal'
require_relative '../lib/invoice'
require_relative '../lib/modules/findable'
require_relative '../lib/modules/crudable'

class InvoiceRepository
  include Findable
  include Crudable
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

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
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

  def find_all_by_date(date)
    @all.find_all do |invoice|
      invoice.created_at == date
    end
  end

  def create(attributes)
    create_new(attributes, Invoice)
  end

  def update(id, attributes)
    invoice = find_by_id(id)
    return invoice.update(attributes) unless invoice.nil?
  end

  def delete(id)
    delete_new(id)
    # delete_item = find_by_id(id)
    # @all.delete(delete_item)
  end
end
