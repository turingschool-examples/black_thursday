class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :parent

  def initialize(data, parent)
    @id = data[:id]
    @customer_id = data[:customer_id]
    @merchant_id = data[:merchant_id]
    @status = data[:status].to_sym
    @created_at = Time.parse(data[:created_at].to_s)
    @updated_at = Time.parse(data[:updated_at].to_s)
    @parent = parent
  end

  def merchant
    parent.call_sales_engine_merchants(merchant_id)
  end

end
