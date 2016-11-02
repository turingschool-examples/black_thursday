require './lib/item_repository'

class Item
  attr_reader   :name,
                :description,
                :unit_price,
                :created_at,
                :updated_at,
                :merchant_id

  def initialize(item_data, parent = nil)
    @item_parent = parent
    @name        = item_data[:name]
    @description = item_data[:description]
    @unit_price  = item_data[:unit_price]
    @created_at  = item_data[:created_at]
    @updated_at  = item_data[:updated_at]
    @merchant_id = item_data[:merchant_id]
  end

end
