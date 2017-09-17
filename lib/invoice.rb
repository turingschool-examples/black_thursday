require_relative 'invoice_repository'
require 'time'


class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :invoice_repository

  def initialize(invoice_repository, csv_info)
    @id = csv_info[:id].to_i
    @customer_id = csv_info[:customer_id].to_i
    @merchant_id = csv_info[:merchant_id].to_i
    @status = csv_info[:status].to_sym
    @created_at = Time.parse(csv_info[:created_at])
    @updated_at = Time.parse(csv_info[:updated_at])
    @invoice_repository = invoice_repository
  end

  def merchant
     id = merchant_id.to_i
     return 0 if id.nil?
     sales_engine = invoice_repository.sales_engine
     merchants = sales_engine.merchants
     merchants.find_by_id(id)
  end

  def items
    invoice_items = invoice_repository.sales_engine.invoice_items.find_all_by_invoice_id(id)
    item_ids = invoice_items.map {|invoice_item| invoice_item.item_id}
    item_ids.map do |item_id|
      invoice_repository.sales_engine.items.find_by_id(item_id)
    end
  end

  def transactions
    invoice_repository.sales_engine.transactions.find_all_by_invoice_id(id)
  end

  def customer
    invoice_repository.sales_engine.customers.find_by_id(customer_id)
  end

end
