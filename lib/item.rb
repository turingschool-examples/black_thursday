class Item

  attr_reader :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(data)
    @name = data[:name]
    @description = data[:description]
    @unit_price = data[:unit_price]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
  end

  def unit_price_to_dollars
    unit_price.to_f / 100
  end
  
end