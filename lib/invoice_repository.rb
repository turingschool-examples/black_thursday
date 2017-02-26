require 'csv'
require_relative 'repository'
require_relative 'invoice'

class InvoiceRepository < Repository

  attr_reader :klass, :data

  def initialize(sales_engine, path)
    super(sales_engine, path, Invoice)
  end

  def all
    data
  end

  def find_by_id(id)
    data.select { |invoice| invoice.id == id }.first
  end

  def find_all_by_customer_id(customer_id)
    data.select { |invoice| invoice.customer_id == customer_id }
  end

  def find_all_by_merchant_id(merchant_id)
    data.select { |invoice| invoice.merchant_id == merchant_id }
  end

  def find_all_by_status(status)
    data.select { |invoice| invoice.status == status }
  end

end
