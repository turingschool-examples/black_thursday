require 'time'

# Item
class Invoice
  attr_reader   :id,
                :created_at,
                :updated_at,
                :status,
                :parent

  attr_accessor :customer_id,
                :merchant_id

  def initialize(item, parent)
    @id = item[:id].to_i
    @customer_id = item[:customer_id]
    @merchant_id = item[:merchant_id].to_i
    @status = item[:status]
    @created_at = Time.parse(item[:created_at].to_s)
    @updated_at = Time.parse(item[:updated_at].to_s)
    @parent = parent
  end
end
