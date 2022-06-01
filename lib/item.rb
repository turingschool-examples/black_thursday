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
    @info[:unit_price]
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

end
