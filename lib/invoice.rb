class Invoice
  attr_accessor :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  attr_reader :repo
              
  def initialize(data, repo)
    @id = data[:id]
    @customer_id = data[:customer_id]
    @merchant_id = data[:merchant_id]
    @status = data[:status]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

end
