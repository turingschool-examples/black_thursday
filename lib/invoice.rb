class Invoice

  attr_reader :id,
              :customer_id,
              :created_at,
              :merchant_id

  attr_accessor :status,
                :updated_at

  def initialize(data)
    @id           = data[:id]
    @customer_id  = data[:customer_id]
    @status       = data[:status]
    @created_at   = data[:created_at]
    @updated_at   = data[:updated_at]
    @merchant_id  = data[:merchant_id]
  end
end
