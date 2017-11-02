class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :parent

  def initialize(attributes, parent)
    @parent = parent
    @id = attributes[:id].to_i
    @customer_id = attributes[:customer_id].to_i
    @merchant_id = attributes[:merchant_id].to_i
    @status = attributes[:status]
    @created_at = Time.new(attributes[:created_at])
    @updated_at = Time.new(attributes[:updated_at])
  end

  def merchant
    parent.find_merchant_by_merchant_id(merchant_id)
  end
end
