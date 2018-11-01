class Item
  attr_reader :info,
              :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(info)
    @info = info
    @id = info[:id]
    @name = info[:name]
    @description = info[:description]
    @unit_price = info[:unit_price]
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
    @merchant_id = info[:merchant_id]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def update(info)
    @name = info[:name] if info[:name]
    @description = info[:description] if info[:description]
    @unit_price = info[:unit_price] if info[:unit_price]
    @updated_at = Time.now
    @merchant_id = info[:merchant_id] if info[:merchant_id]
  end

end
