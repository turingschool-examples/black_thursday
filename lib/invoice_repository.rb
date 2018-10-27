require 'pry'
require 'CSV'
require 'time'
require_relative './invoice'
require_relative './repository'

class InvoiceRepository < Repository

  def new_record(row)
    Invoice.new(row)
  end

  def find_all_by_customer_id(customer_id)
    @repo_array.find_all do |item|
      item.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @repo_array.find_all do |item|
      item.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    @repo_array.find_all do |item|
      item.status == status
    end
  end

  def create(attributes)
    attributes[:id] = new_highest_id
    @repo_array << new_item = Invoice.new(attributes)
    new_item
  end

  def update(id, attributes)
    invoice = find_by_id(id)
    return nil if invoice.nil?
    invoice.status = attributes[:status] unless attributes[:status].nil?
    invoice.updated_at = Time.now
    invoice
  end

end
