require 'csv'
require 'time'


class Invoice

  attr_reader :id, :created_at, :updated_at, :merchant_id, :customer_id, :status, :engine

  def initialize(invoice_info, engine)
    @id = invoice_info[:id].to_i
    @customer_id = invoice_info[:customer_id].to_i
    @status = invoice_info[:status].to_sym
    @created_at = Time.parse(invoice_info[:created_at])
    @updated_at = Time.parse(invoice_info[:updated_at])
    @merchant_id = invoice_info[:merchant_id].to_i
    @engine = engine
  end

  def merchant
    @engine.merchants.find_by_id(@merchant_id)
  end
end
