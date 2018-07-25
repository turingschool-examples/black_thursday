class Invoice

  attr_reader :id

  attr_accessor :updated_at

  def initialize(info)
    @id = info[:id].to_i
    @customer_id = info[:customer_id].to_i
    @merchant_id = info[:merchant_id].to_i
    @status = info[:status]
    @created_at = Time.parse(info[:created_at].to_s)
    @updated_at = Time.parse(info[:updated_at].to_s)
  end
end
