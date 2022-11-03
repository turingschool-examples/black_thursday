require_relative 'reposable'
require_relative './invoice.rb'

class InvoiceRepository
  include Reposable

  attr_accessor :all

  def initialize(all = [])
    @all = all
  end

  def find_all_by_customer_id(customer_id)
    @all.find_all do |invoice|
      customer_id == invoice.customer_id
    end
  end
  
  def find_all_by_merchant_id(merchant_id)

    @all.find_all do |invoice|
      merchant_id.to_s == invoice.merchant_id
    end
  end

  def find_all_by_status(invoice_status)
    @all.find_all do |invoice|
      invoice.status == invoice_status
    end
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end
end