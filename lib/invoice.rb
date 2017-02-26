require 'date'

class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at, :invoice_repository

  def initialize(info = {}, invoice_repository = "")
    @id = info[:id].to_i
    @customer_id = info[:customer_id].to_i
    @merchant_id = info[:merchant_id].to_i
    @status = info[:status].to_sym
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
    @invoice_repository = invoice_repository
  end

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end
  
  def merchant
    invoice_repository.engine.merchants.find_by_id(merchant_id)
  end
end