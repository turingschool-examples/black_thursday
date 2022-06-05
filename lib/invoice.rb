class Invoice

attr_reader  :id,
             :customer_id,
             :status,
             :created_at,
             :updated_at,
             :merchant_id


  def initialize(data)
    @id = data[:id]
    @customer_id = data[:customer_id]
    @status = data[:status]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @merchant_id = data[:merchant_id]
  end
end
