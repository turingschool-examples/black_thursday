require 'time'
class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at
  def initialize(data, sales_engine)
    @sales_engine = sales_engine
    @id           = data[:id].to_i
    @customer_id  = data[:customer_id].to_i
    @merchant_id  = data[:merchant_id].to_i
    @status       = data[:status].to_sym          if data[:status]
    @created_at   = Time.parse(data[:created_at]) if data[:created_at]
    @updated_at   = Time.parse(data[:updated_at]) if data[:updated_at]
  end

  def merchant
    @sales_engine.merchants.find_by_id(self.merchant_id)
  end

end
