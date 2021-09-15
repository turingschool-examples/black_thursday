class Item
attr_accessor   :id,
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
    if !attributes[:name].nil?
      @name = attributes[:name]
    end
    if !attributes[:description].nil?
      @description = attributes[:description]
    end
    if !attributes[:unit_price].nil?
      @unit_price = attributes[:unit_price]
    end
    @updated_at = Time.now
    self
  end
end
