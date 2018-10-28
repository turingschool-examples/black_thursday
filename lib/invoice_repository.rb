require 'csv'
require_relative '../lib/invoice'
require_relative '../lib/find_methods'
class InvoiceRepository
  include FindMethods
  def initialize(data)
    @collection = data
  end

  def find_by_customer_id(id)
    @collection.find_all do |element|
      element.customer_id == id
    end
  end

  def find_by_merchant_id(id)
    @collection.find_all do |element|
      element.merchant_id == id
    end
  end
end
