class Item

  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :updated_at

  def initialize(item_hash)
    @id = item_hash[:id]
    @name = item_hash[:name]
    @description = item_hash[:description]
    @unit_price = item_hash[:unit_price]
    @created_at = Time.now.getutc
    @updated_at = Time.now.getutc
    @merchant_id = item_hash[:merchant_id]
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def create_id(new_id)
    @id = new_id
  end

  def change_name(new_name)
    @name = new_name
  end

  def change_description(new_description)
    @description = new_description
  end

  def change_unit_price(new_price)
    @unit_price = new_price
  end

  def change_updated_at
    @updated_at = Time.now.getutc
  end

end
