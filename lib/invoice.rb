class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :created_at
  attr_accessor :status,
                :updated_at

  def initialize(input_hash)
    @id           = input_hash[:id].to_i
    @customer_id  = input_hash[:customer_id].to_i
    @merchant_id  = input_hash[:merchant_id].to_i
    @status       = input_hash[:status].to_sym
    @created_at   = Time.parse(input_hash[:created_at].to_s)
    @updated_at   = Time.parse(input_hash[:updated_at].to_s)
  end


end