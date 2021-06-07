require './module/incravinable'

class Item
  include Incravinable

  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,
              :item_data

  def initialize(item_data)
    @id = item_data[:id].to_i
    @name = item_data[:name]
    @description = item_data[:description]
    @unit_price = item_data[:unit_price].to_f
    @created_at = item_data[:created_at]
    @updated_at = item_data[:updated_at]
    @merchant_id = item_data[:merchant_id].to_i
    @item_data = item_data
  end

  def unit_price_to_dollars
    @unit_price.to_f.round(2)
  end

  def new_id(id_number)
    @id = id_number
  end

  def update_attributes(attributes)
   update_name(new_name = attributes[:name])
   update_description(new_description = attributes[:description])
   update_unit_price(new_price = attributes[:unit_price])
 end

  def update_name(new_name)
    return nil if new_name == nil
    @name = new_name
  end

  def update_description(new_description)
    return nil if new_description == nil
    @description = new_description
  end

  def update_unit_price(new_price)
    return nil if new_price == nil
    @unit_price = new_price
  end

  def item_hash
    @item_data
  end
end
