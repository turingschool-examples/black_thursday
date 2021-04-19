class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status

  def initialize(transaction_details)
    @id = transaction_details[:id].to_i
    @customer_id = transaction_details[:customer_id].to_i
    @merchant_id = transaction_details[:merchant_id].to_i
    @status = transaction_details[:status].to_sym
    @created_at = transaction_details[:created_at]
    @updated_at = transaction_details[:updated_at]
  end

  def update_id(id)
    @id = id
  end

  def update_status(status)
    @status = status unless status.nil?
  end

  def update_time
    @updated_at = Time.now
  end

  def created_at
    return @created_at if @created_at.instance_of?(Time)

    Time.parse(@created_at)
  end

  def updated_at
    return @updated_at if @updated_at.instance_of?(Time)

    Time.parse(@updated_at)
  end
end
