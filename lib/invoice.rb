class Invoice
  attr_reader :customer_id,
              :merchant_id,
              :created_at

  attr_accessor :id,
                :status,
                :updated_at

  def initialize(info_hash)
    @id = info_hash[:id].to_i
    @customer_id = info_hash[:customer_id].to_i
    @merchant_id = info_hash[:merchant_id].to_i
    @status = info_hash[:status].to_sym
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
