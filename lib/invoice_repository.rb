require 'csv'
require 'time'
require_relative '../lib/invoice'
require_relative '../lib/repository'

class InvoiceRepository

  include Repository

  def initialize(invoices)
    @collection = invoices
  end
  #I need
  #find_all_by_customer_id
  def find_all_by_customer_id(id)
    all.find_all do |invoice|
      invoice.customer_id == id
    end
  end
  #find_all_by_merchant_id
  def find_all_by_merchant_id(id)
    all.find_all do |invoice|
      invoice.merchant_id == id
    end
  end
  #find_all_by_status
  def find_all_by_status(stat)
    all.find_all do |invoice|
      invoice.status == stat
    end
  end
  #create(attributes) Takes id and invoice)
  def create(attributes)
    new_id = max_id + 1
    customer_id = attributes[:customer_id]
    merchant_id = attributes[:merchant_id]
    status = attributes[:status]
    created_at = Time.now.to_s
    updated_at = Time.now.to_s
    new_invoice = Invoice.new({id: new_id, customer_id: customer_id,
     merchant_id: merchant_id, status: status, created_at: created_at,
     updated_at: updated_at})
    @collection << new_invoice
    new_invoice
  end
  #update(id, attributes)
  def update(id, attributes)
    if find_by_id(id)
      invoice = find_by_id(id)
      new_status = attributes[:status]
      invoice.status = new_status if attributes[:status]
      invoice.updated_at = Time.now
    end
  end

end
