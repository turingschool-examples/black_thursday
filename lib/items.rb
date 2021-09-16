class Item
  attr_accessor  :id,
                 :name,
                 :description,
                 :unit_price,
                 :created_at,
                 :updated_at,
                 :merchant_id

  def initialize(item)
    @id = item[:id]
    @name = item[:name]
    @description = item[:description]
    @unit_price = item[:unit_price]
    @created_at = item[:created_at]
    @updated_at = item[:updated_at]
    @merchant_id = item[:merchant_id]
  end

  def unit_price_to_dollars
    unit_price.to_f
  end

  def update_item(attributes)
    @name = attributes[:name] if !attributes[:name].nil?
    @description = attributes[:description] if !attributes[:description].nil?
    @unit_price = attributes[:unit_price] if !attributes[:unit_price].nil?
    @updated_at = Time.now
    self
  end
end
