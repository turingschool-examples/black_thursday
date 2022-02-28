class Invoice 
  attr_reader :id, :customer_id, :merchant_id, :status, :created_at, :updated_at
    def initialize(info)
      @id = info[:id]
      @customer_id = info[:customer_id]
      @merchant_id = info[:merchant_customerid]
      @status = info[:status].to_s
      @created_at = info[:created_at].to_s
      @updated_at = info[:updated_at].to_s
    end
    
end 
