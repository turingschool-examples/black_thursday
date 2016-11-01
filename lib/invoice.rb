class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(data)
    @id           = data[:id].to_i
    @customer_id  = data[:customer_id]
    @merchant_id  = data[:merchant_id]
    @status       = data[:status].to_sym
    @created_at   = data[:created_at]
    @updated_at   = data[:updated_at]
  end
end