require_relative 'find'
require_relative 'modify'
require_relative 'invoice'

class InvoiceRepository
  include Find
  include Modify

  attr_reader :invoices
  def initialize
    @invoices = []
  end

  def add(invoice)
    @invoices << Invoice.new(invoice)
  end

  def find_all_by_customer_id(id)
    @invoices.find_all do |invoice|
      invoice.customer_id == id
    end
  end

  def find_all_by_status(status)
    @invoices.find_all do |invoice|
      invoice.status == status
    end
  end

  def all
    @invoices
  end

  def find_by_id(id)
    find_by_id_overall(@invoices, id)
  end

  def find_all_by_merchant_id(merch_id)
    find_all_by_merchant_id_overall(@invoices, merch_id)
  end

  def create(attributes)
    create_overall(@invoices, attributes)
  end

  def update(id, attributes)
    update_overall(@invoices, id, attributes)
  end

  def delete(id)
    delete_overall(@invoices, id)
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end
end