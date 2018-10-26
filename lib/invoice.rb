
class Invoice
  attr_reader :id, :customer_id, :merchant_id, :created_at
  attr_accessor :updated_at, :status

  def initialize(info)
    @id = info[:id]
    @customer_id = info[:customer_id]
    @merchant_id = info[:merchant_id]
    @status= info[:status]
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
  end

end
