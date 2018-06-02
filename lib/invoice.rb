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
    @status = data[:status].to_sym
    @created_at = Time.parse(data[:created_at].to_s)
    @updated_at = Time.parse(data[:updated_at].to_s)
  end

  def update_status(new_status)
    @status = new_status.to_sym
  end

  def update_time(new_time)
    @updated_at = new_time
  end

  def created_day_of_week
    Date::DAYNAMES[@created_at.wday]
  end
end
