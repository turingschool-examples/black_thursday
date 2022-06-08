class Item
  attr_reader :id,
              :created_at,
              :merchant_id
  attr_accessor :name,
                :description,
                :unit_price,
                :updated_at

  def initialize(details)
    @id = details[:id]
    @name = details[:name]
    @description = details[:description]
    @unit_price = details[:unit_price].to_f
    @created_at = details[:created_at]
    @updated_at = details[:updated_at]
    @merchant_id = details[:merchant_id]
  end

  def unit_price_to_dollars
    @unit_price.round(2)
  end

end
