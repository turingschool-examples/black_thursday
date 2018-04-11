require 'time'
# Element module for object type classes
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

  def customer_id
    @attributes[:customer_id].to_i
  end

  def status
    @attributes[:status].to_sym
  end

  def merchant
    @engine.merchants.find_by_id(merchant_id)
  end

  def invoices
    @engine.invoices.find_all_by_merchant_id(id)
  end
end
