class Item
  def initialize(info_hash)
    @info = info_hash
  end

  def id
    @info[:id].to_i
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

  def merchant_id
    @info[:merchant_id].to_i
  end

  def created_at
    @info[:created_at]
  end

  def updated_at
    @info[:updated_at]
  end
end