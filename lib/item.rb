class Item
  attr_reader :data
  def initialize(item)
    @data = {
      id:          item[:id],
      name:        item[:name],
      description: item[:description],
      unit_price:  BigDecimal.new(item[:unit_price], 4),
      created_at:  item[:created_at],
      updated_at:  item[:updated_at],
      merchant_id: item[:merchant_id]
    }
  end

  def id
    data[:id].to_i
  end

  def name
    data[:name]
  end

  def description
    data[:description]
  end

  def unit_price
    data[:unit_price]
  end

  def created_at
    data[:created_at]
  end

  def updated_at
    data[:updated_at]
  end

  def merchant_id
    data[:merchant_id].to_i
  end

  def unit_price_to_dollars
    unit_price.to_f
  end
end
