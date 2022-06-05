class Invoice
  attr_reader :id, :customer_id, :merchant_id, :created_at
  attr_accessor :status, :updated_at

  def initialize(invoice)
    @id = invoice[:id].to_i
    @customer_id = invoice[:customer_id].to_i
    @merchant_id = invoice[:merchant_id].to_i
    @status = invoice[:status].to_sym
    @created_at = invoice[:created_at]
    @updated_at = invoice[:updated_at]
  end
end
