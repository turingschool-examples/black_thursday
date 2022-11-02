require_relative 'find'
require_relative 'modify'

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
end