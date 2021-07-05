class Item

  def initialize(attributes)
    @attributes = attributes
  end

  def id
    @attributes[:id].to_i
  end

  def name
    @attributes[:name]
  end

  def description
    @attributes[:description]
  end

  def unit_price
    @attributes[:unit_price]
  end

  def created_at
    @attributes[:created_at]
  end

  def updated_at
    @attributes[:updated_at]
  end

  def merchant_id
    @attributes[:merchant_id]
  end

  def unit_price_to_dollars
    @attributes[:unit_price].to_f
  end
end
