class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(attributes)
    @id = attributes[:id].to_i
    @customer_id = attributes[:customer_id]
    @merchant_id = attributes[:merchant_id]
    @status = attributes[:status].to_sym
    @created_at = attributes[:created_at]
    @updated_at = attributes[:updated_at]
  end
end
