require './lib/helper'
require 'pry'

class InvoiceRepository

  attr_reader :all,
              :parent

  def initialize(invoice_data, parent)
    @all = invoice_data.map { |raw_invoice| Invoice.new(raw_invoice, self)}
    @parent = parent
  end

  def find_by_id(id)
    all.find do |invoice|
      invoice.id == id
    end
  end

  def find_all_by_customer_id(customer_id)
    all.find_all do |invoice|
      invoice.customer_id == customer_id
    end
  end

  def find_all_by_merchant_id(merchant_id)
    all.find_all do |invoice|
      invoice.merchant_id == merchant_id
    end
  end

  def find_all_by_status(status)
    all.find_all do |invoice|
      invoice.status == status
    end
  end

  def find_merchant(merchant_id)
    parent.merchants.find_by_id(merchant_id)
  end

  def all_weekdays_created_at
    all.map do |invoice|
      invoice.weekday_created
    end
  end

  def invoices_per_day
    all_weekdays_created_at.reduce(Hash.new(0)) do |hash, day|
      hash[day] += 1
      hash
    end
  end

  def find_invoice_items(invoice_id)
    parent.find_items_by_invoice_id(invoice_id)
  end

  def find_transactions(invoice_id)
    parent.find_transactions_by_invoice_id(invoice_id)
  end

  def find_customer(customer_id)
    parent.find_customer_by_customer_id(customer_id)  
  end
  
  def inspect
    "#<#{self.class} #{@all.size} rows>"
  end

end