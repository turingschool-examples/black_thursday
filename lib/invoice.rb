
class Invoice

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(datum, parent_repo = nil)
    @id = datum[:id].to_i
    @customer_id = datum[:customer_id].to_i
    @merchant_id = datum[:merchant_id].to_i
    @status = datum[:status]
    @created_at = Time.parse(datum[:created_at])
    @updated_at = Time.parse(datum[:updated_at])
    @parent_repo = parent_repo
  end

  def merchant
    @parent_repo.find_merchant(merchant_id)
  end

end
