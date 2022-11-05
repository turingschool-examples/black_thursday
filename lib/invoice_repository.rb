require 'csv'
require_relative './invoice'
require 'pry'

class InvoiceRepository
    attr_reader :invoice_repo

  def initialize
    @invoice_repo = []
  end

  def create(attributes)
    unless invoice_repo.empty?
    attributes[:id] = all.max do |invoice|
      invoice.id
      end.id + 1
    end
    new_invoice = Invoice.new(attributes)
    @invoice_repo << new_invoice
    new_invoice
  end

  def all
    @invoice_repo
  end

  def find_by_id(id)
    invoice_repo.find do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_customer_id(customer_id)
    invoice_repo.select do |invoice|
        invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    invoice_repo.select do |invoice|
        invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    invoice_repo.select do |invoice|
        invoice.status == status.to_sym
    end
  end

  def update(id, attributes)
    if updated_invoice = find_by_id(id)
      updated_invoice.status = attributes[:status]
    elsif 
    end
  end

  def inspect
    "#<#{self.class} #{@invoice_repo.size} rows>"
  end
end