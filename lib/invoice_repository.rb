require 'csv'
require_relative '../lib/invoice'
require_relative '../lib/find_methods'
class InvoiceRepository
  include FindMethods
  def initialize(data)
    @collection = data
  end

  def find_all_by_customer_id(id)
    @collection.find_all do |element|
      element.customer_id == id
    end
  end

  def find_all_by_merchant_id(id)
    @collection.find_all do |element|
      element.merchant_id == id
    end
  end

  def find_all_by_status(status)
    @collection.find_all do |element|
      element.status.include?(status)
    end
  end

  def create(attributes)
    highest = @collection.max_by do |item|
      item.id.to_i
    end
    number = highest.id.to_i + 1
    new_invoice = Invoice.new( {
                                 id: number,
                                 customer_id: attributes[:customer_id],
                                 merchant_id: attributes[:merchant_id],
                                 status: attributes[:status],
                                 created_at: attributes[:created_at],
                                 updated_at: attributes[:updated_at]
                                } )
    @collection << new_invoice
    new_invoice 
  end
end
