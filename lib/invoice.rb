class Invoice
attr_reader :id,
            :created_at,
            :updated_at,
            :customer_id,
            :merchant_id,
            :status

  def initialize(info)
    @id          = info[:id]
    @customer_id = info[:customer_id]
    @merchant_id = info[:merchant_id]
    @status      = info[:status]
    @created_at  = Time.parse(info[:created_at])
    @updated_at  = Time.parse(info[:updated_at])
  end
end
