class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(data)
    @id = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status = data[:status].to_s
    @created_at = data[:created_at].to_s
    @updated_at = data[:updated_at].to_s
  end

  def update_time(time)
    if time.nil?
      Time.now
    elsif time.empty?
      Time.now
    else
      Time.parse(time)
    end
  end

  def update(attributes)
    @status = attributes[:status] if !attributes[:status].nil?
    @updated_at  = update_time("")
  end
end
