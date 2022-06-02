class Item
  attr_reader :id, :name, :description, :unit_price, :created_at,
  :updated_at, :merchant_id

  def initialize(item_data)
    @id = item_data[:id]
    @name = item_data[:name]
    @description = item_data[:description]
    @unit_price = item_data[:unit_price]
    @created_at = item_data[:created_at]
    @updated_at = item_data[:updated_at]
    @merchant_id = item_data[:merchant_id]
  end

  def unit_price_to_dollars
    (@unit_price.to_f).round(2)
  end

  def change(key, value)
    if key == :unit_price
      @unit_price = value
    elsif key == :description
      @description = value
    elsif key == :name
      @name = value
    else
      return nil
    end
    @updated_at = Time.now
  end

end
