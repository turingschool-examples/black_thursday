class Invoice
  attr_accessor     :id,
                    :customer_id,
                    :merchant_id,
                    :status,
                    :created_at,
                    :updated_at

  def initialize(item_attributes)
    @id = item_attributes[:id].to_i
    @customer_id = item_attributes[:customer_id].to_i
    @merchant_id = item_attributes[:merchant_id].to_i
    @status = item_attributes[:status].to_sym
    @created_at = time_conversion(item_attributes[:created_at])
    @updated_at = time_conversion(item_attributes[:updated_at])
  end

  def time_conversion(time)
    if time.class == String
      time = Time.parse(time)
    end
    time
  end
end
