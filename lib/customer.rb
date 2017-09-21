require 'csv'
require 'time'
require_relative 'sales_engine'

class Customer

  attr_reader :id, :first_name, :last_name, :created_at, :updated_at,:engine

  def initialize(customer_info, engine)
    @id = customer_info[:id].to_i
    @first_name = customer_info[:first_name]
    @last_name = customer_info[:last_name]
    @created_at = Time.parse(customer_info[:created_at])
    @updated_at = Time.parse(customer_info[:updated_at])
    @engine = engine
  end

  def merchants
    customer_invoices = @engine.invoices.find_all_by_customer_id(@id)
    merchant_ids = customer_invoices.map {|invoice| invoice.merchant_id}
    merchants = merchant_ids.map do |merchant_id|
      @engine.merchants.find_by_id(merchant_id)
    end
  end

end
