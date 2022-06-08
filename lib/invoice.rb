class Invoice

  attr_accessor :id,
                :customer_id,
                :merchant_id,
                :status,
                :created_at,
                :updated_at

  def initialize(details)
    @id = details[:id].to_i
    @customer_id = details[:customer_id].to_i
    @merchant_id = details[:merchant_id].to_i
    @status = details[:status]
    @created_at = details[:created_at]
    @updated_at = details[:updated_at]
  end

end
