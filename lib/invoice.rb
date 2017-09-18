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
     #merchant_repository.sales_engine.items.find_all_by_merchant_id(id)
     #item_repository.se.merchants.find_by_id(id)

     id = merchant_id.to_i
     return 0 if id.nil?
     sales_engine = invoice_repository.sales_engine
     merchants = sales_engine.merchants
     #binding.pry
     merchants.find_by_id(id)
  end

  def is_paid_in_full?
    #check all transactionsby this id to make sure there IS a transaction, and finally to see if there is at least 1 successful "result"
    sales_engine.transations.find_all_by_result(successful) #returns a transaction array.
    #search transaction array for self.merchant_id
  end

end
