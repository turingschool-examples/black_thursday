class Item

  attr_reader :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(information)
    @name = information[:name]
    @description = information[:description]
    @unit_price = information[:unit_price]
    @created_at = information[:created_at]
    @updated_at = information[:updated_at]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

end
