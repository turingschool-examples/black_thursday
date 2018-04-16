require 'time'
# Element module for object type classes
module Element
  attr_reader :attributes

  def id
    @attributes[:id].to_i
  end

  def name
    @attributes[:name]
  end

  def unit_price
    price = @attributes[:unit_price].to_i
    BigDecimal.new(price) / 100
  end

  def created_at
    time = @attributes[:created_at]
    if time.class == Time
      time
    else
    Time.parse(@attributes[:created_at])
    end
  end

  def updated_at
    time = @attributes[:updated_at]
    if time.class == Time
      time
    else
    Time.parse(@attributes[:updated_at])
    end
  end

  def merchant_id
    @attributes[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @attributes[:unit_price].to_f / 100
  end

  def invoice_id
    @attributes[:invoice_id].to_i
  end

  def update(states)
    attributes[:name] = states[:name] if states[:name]
    attributes[:unit_price] = states[:unit_price] * 100 if states[:unit_price]
    attributes[:updated_at] = Time.now
  end
end
