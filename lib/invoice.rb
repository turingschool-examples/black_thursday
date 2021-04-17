class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(info_hash)
    @id = info_hash[:id].to_i
    @customer_id = info_hash[:customer_id].to_i
    @merchant_id = info_hash[:merchant_id]
    @status = info_hash[:status]
    @created_at = time_check(info_hash[:created_at])
    @updated_at = time_check(info_hash[:updated_at])
  end

  def time_check(time)
    if time.class == Time
      time
    else
      Time.parse(time)
    end
  end

end
