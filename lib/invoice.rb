class Invoice
attr_reader :id,
            :created_at,
            :customer_id,
            :merchant_id
            
attr_accessor :status,
              :updated_at

  def initialize(info)
    @id          = info[:id].to_i
    @customer_id = info[:customer_id].to_i
    @merchant_id = info[:merchant_id].to_i
    @status      = info[:status].to_sym
    @created_at  = Time.parse(info[:created_at])
    @updated_at  = Time.parse(info[:updated_at])
  end
end
