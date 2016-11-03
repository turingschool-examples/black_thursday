require_relative '../lib/item_repository'

class Item
  attr_reader   :name,
                :description,
                :unit_price,
                :created_at,
                :updated_at,
                :merchant_id,
                :id

  def initialize(item_data, parent = nil)
    @item_parent = parent
    @name        = item_data[:name]
    @id          = item_data[:id].to_i
    @description = item_data[:description]
    @unit_price  = item_data[:unit_price]
    @created_at  = item_data[:created_at]
    @updated_at  = item_data[:updated_at]
    @merchant_id = item_data[:merchant_id].to_i
  end

end
