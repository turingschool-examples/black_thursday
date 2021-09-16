class Items
  attr_accessor :id,
                :name,
                :description,
                :unit_price,
                :merchant_id,
                :created_at,
                :updated_at

  def initialize(items)
    @id = items[:id]
    @name = items[:name]
    @description = items[:description]
    @unit_price = items[3]
    @merchant_id = items[4]
    @created_at = items[5]
    @updated_at = items[6]
  end

end
