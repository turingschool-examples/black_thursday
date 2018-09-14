class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :created_at


  attr_accessor :status,
                :updated_at

  def initialize(data)
    @id = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status = data[:status].to_sym
    @created_at = data[:created_at].to_s
    @updated_at = data[:updated_at].to_s
  end

  def created_at
    if @created_at != nil
      Time.parse(@created_at)
    end
  end

  def updated_at
    if @updated_at != nil
      Time.parse(@updated_at)
    end
  end
end
