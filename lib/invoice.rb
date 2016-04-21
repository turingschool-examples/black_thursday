require 'time'
class Invoice
  attr_reader :id, :customer_id, :merchant_id, :status, 
              :sales_engine

  def initialize(data, sales_engine)
    @id = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status = data[:status]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @sales_engine = sales_engine
  end

  def created_at
    Time.parse(@created_at)
  end

  def updated_at
    Time.parse(@updated_at)
  end

  def merchant
    sales_engine.merchant_repo.find_by_id(merchant_id)
  end

end
