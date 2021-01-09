class Invoice
  
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :parent

  def intialize(args, parent)
    @id = args[:id]
    @customer_id = args[:customer_id]
    @merchant_id = args[:merchant_id]
    @status = args[:status]
    @created_at = Time.now
    @updated_at = Time.now
    @parent = parent
  end
end
