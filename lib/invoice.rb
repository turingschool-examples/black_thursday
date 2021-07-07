require 'time'

class Invoice
  attr_reader :id,
              :created_at,
              :merchant_id,
              :customer_id
  attr_accessor :status,
                :updated_at

  def initialize(hash)
    @id = hash[:id].to_i
    @customer_id = hash[:customer_id].to_i
    @merchant_id = hash[:merchant_id].to_i
    @status = hash[:status]
    @created_at = Time.parse(hash[:created_at].to_s)
    @updated_at = Time.parse(hash[:updated_at].to_s)
  end
end
