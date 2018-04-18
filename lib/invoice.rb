class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :parent

  def initialize(data, parent)
    @id = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status = data[:status]
    @created_at = data[:created_at]
    @updated_at =  data[:updated_at]
  end

  def created_at
    Time.parse(@created_at.to_s)
  end

  def updated_at
    Time.parse(@updated_at.to_s)
  end

end
