class Item
  attr_reader :info
  def initialize(info)
    @info = info
  end

  def id
    @info[:id]
  end

  def name
    @info[:name]
  end

  def description
    @info[:description]
  end

  def unit_price
    BigDecimal(@info[:unit_price ])/100
  end

  def created_at
    @info[:created_at]
  end

  def updated_at
    @info[:updated_at]
  end

  def merchant_id
    @info[:merchant_id]
  end

  def unit_price_to_dollars
    unit_price.truncate(2).to_f
  end

end
