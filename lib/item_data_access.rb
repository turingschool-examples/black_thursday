module ItemDataAccess
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at,
              :parent,
              :customer_id,
              :status,
              :item_id,
              :invoice_id,
              :quantity

  def initialize(data, parent=nil)
    @id  = data[:id]
    @name = data[:name]
    @description = data[:description]
    @unit_price =  data[:unit_price]
    @merchant_id = data[:merchant_id]
    @created_at  = data[:created_at]
    @updated_at = data[:updated_at]
    @parent = parent
    @customer_id = data[:customer_id]
    @status = data[:status]
  end
end
