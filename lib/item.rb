class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(item_data)
    @id = item_data[:id].to_i
    @name = item_data[:name]
    @description = item_data[:description]
    @unit_price = item_data[:unit_price].to_f
    @created_at = item_data[:created_at]
    @updated_at = item_data[:updated_at]
    @merchant_id = item_data[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @unit_price.to_f.round(2)
  end

  def new_id(id_number)
    @id = id_number
  end

  def update_name(new_name)
    @name = new_name
  end

  def update_description(new_description)
    @description = new_description
  end

  def update_unit_price(new_price)
    @unit_price = new_price
  end

  def update_updated_at
    @updated_at = Time.now
  end
end
