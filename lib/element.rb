module Element
  attr_accessor :attributes

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
    price = @attributes[:unit_price].to_i
    BigDecimal.new(price)/100
  end

  def created_at
    @attributes[:created_at]
  end

  def updated_at
    @attributes[:updated_at]
  end

  def merchant_id
    @attributes[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @attributes[:unit_price].to_f/100
  end
end
