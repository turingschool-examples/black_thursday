class Customer
  attr_reader         :id,
                      :first_name,
                      :last_name,
                      :created_at,
                      :updated_at
  def initialize(data, cr = nil)
    @cr               = cr
    @id               = data[:id].to_i
    @first_name       = data[:first_name]
    @last_name        = data[:last_name]
    @created_at       = Time.parse(data[:created_at])
    @updated_at       = Time.parse(data[:updated_at])
  end

  def merchants
    @cr.fetch_merchant_by_customer_id(id)
  end
end
