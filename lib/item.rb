class Item
  attr_reader   :id,
                :created_at,
                :updated_at,
                :merchant_id
              
  attr_accessor :name,
                :description,
                :unit_price

  def initialize(item_hash)
    @name = item_hash[:name]
    @description = item_hash[:description]
    @id = item_hash[:id]
    @unit_price = item_hash[:unit_price]
    @created_at = item_hash[:created_at]
    @updated_at = item_hash[:updated_at]
    @merchant_id = item_hash[:merchant_id]
  end
end
