# require 'csv'

class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at

  def initialize(info)
    @id = info[:id]
    @customer_id = info[:customer_id]
    @merchant_id = info[:merchant_id]
    @status = info[:status]
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
  end

end
