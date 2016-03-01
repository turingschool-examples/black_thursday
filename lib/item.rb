

class Item

  def initialize(item_info_hash)
    @id = item_info_hash[:id]
    @name = item_info_hash[:name]
    @description = item_info_hash[:description]
    @unit_price = item_info_hash[:unit_price]
    @merchant_id = item_info_hash[:merchant_id]
    @created_at = item_info_hash[:created_at]
    @updated_at = item_info_hash[:updated_at]
  end

  def id
    @id
  end

  def name
    @name
  end

  def description
    @description
  end

  def unit_price
    @unit_price
  end

  def merchant_id
    @merchant_id
  end

  def created_at
    @created_at
  end

  def updated_at
    @updated_at
  end

  def unit_price_to_dollars
    (@unit_price/100).to_f
  end

  def inspect
    " id: #{id}
    name: #{name}
    description: #{description}
    unit price: #{unit_price}
    merchant id: #{merchant_id}
    created at: #{created_at}
    updated at: #{updated_at}"
  end

  def update_updated_at_time
    @updated_at = Time.now
  end

end
