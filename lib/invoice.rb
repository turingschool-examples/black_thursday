require 'bigdecimal'
require 'time'

class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at
  def initialize(stats)
    @id = stats[:id]
    @customer_id = stats[:customer_id]
    @merchant_id = stats[:merchant_id]
    @status = stats[:status]
    @created_at = stats[:created_at]
    @updated_at = stats[:updated_at]
  end

end
