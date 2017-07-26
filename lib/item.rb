class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,
              :ir

  def initialize(id, name, description, unit_price,
                created_at, updated_at, merchant_id, ir)
    @id = id
    @name = name
    @description = description
    @unit_price = unit_price
    @created_at = created_at
    @updated_at = updated_at
    @merchant_id = merchant_id
    @ir = ir
  end

  def unit_price_to_dollars
    (@unit_price / 100.00)
  end

  def merchant
    ir.fetch_items_merchant_id(self.merchant_id)
  end

end