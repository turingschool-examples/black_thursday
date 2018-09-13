require 'pry'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(sale_stats)
    @sale_stats = {}
    @id = sale_stats[:id]
    @customer_id = sale_stats[:customer_id]
    @merchant_id = sale_stats[:merchant_id]
    @status = sale_stats[:status]
    @created_at = sale_stats[:created_at]
    @updated_at = sale_stats[:updated_at]
  end


end
