class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(attributes, parent)
    @id = attributes[:id].to_i
    @customer_id = attributes[:customer_id].to_i
    @merchant_id = attributes[:merchant_id].to_i
    @status = attributes[:status].to_sym
    @created_at = Time.parse(attributes[:created_at])
    @updated_at = Time.parse(attributes[:updated_at])
    @parent = parent
  end

end
