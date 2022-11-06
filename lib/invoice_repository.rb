require 'csv'
require_relative 'invoice'
require_relative 'repository'
require 'pry'

class InvoiceRepository < Repository

  def new_obj(attributes)
    new_obj = Invoice.new(attributes)
    @repo << new_obj
    new_obj
  end

  def find_all_by_customer_id(customer_id)
    @repo.select do |invoice|
        invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    @repo.select do |invoice|
        invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    @repo.select do |invoice|
        invoice.status == status.to_sym
    end
  end
end