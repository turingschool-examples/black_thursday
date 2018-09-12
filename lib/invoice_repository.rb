require_relative '../lib/invoice'
require_relative '../lib/repo_module'
require 'time'

class InvoiceRepository
  include RepoModule

  def initialize
    @data = []
  end

  def create(attributes)
    #all incoming data must be formatted as String datatype
    if attributes[:id] != nil
      #Coming From CSV
      hash = {
        id: attributes[:id].to_i,
        customer_id: attributes[:customer_id].to_i,
        merchant_id: attributes[:merchant_id].to_i,
        status: attributes[:status].to_sym,
        updated_at: Time.parse(attributes[:updated_at]),
        created_at: Time.parse(attributes[:created_at]),
        }
      invoice = Invoice.new(hash)
      @data << invoice
    else
      #Generated on the fly
      hash = {
        id: find_next_id,
        customer_id: attributes[:customer_id].to_i,
        merchant_id: attributes[:merchant_id].to_i,
        status: attributes[:status],
        updated_at: Time.now,
        created_at: Time.now,
        }
      invoice = Invoice.new(hash)
      @data << invoice
    end
  end

  def find_all_by_customer_id(search_customer_id)
    @data.find_all do |invoice|
      invoice.customer_id == search_customer_id
    end
  end

  def find_all_by_merchant_id(search_merchant_id)
    @data.find_all do |invoice|
      invoice.merchant_id == search_merchant_id
    end
  end

  def find_all_by_status(search_status)
    @data.find_all do |invoice|
      invoice.status.downcase == search_status.downcase
    end
  end

  def update(id, attributes)
    if find_by_id(id) != nil
      update_attributes(id, attributes)
      find_by_id(id).updated_at = Time.now
    end
  end
end
