
class Invoice
  attr_accessor :id, :customer_id, :merchant_id, :status, :created_at, :updated_at

  def initialize(args_hash)
    @id          = args_hash[:id].to_i
    @customer_id = args_hash[:customer_id]
    @merchant_id = args_hash[:merchant_id]
    @status      = args_hash[:status]
    @created_at  = args_hash[:created_at]
    @updated_at  = args_hash[:updated_at]
  end

end
