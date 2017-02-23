require 'bigdecimal'

class Item

  attr_reader :item_hash

  def initialize(hash)
    @item_hash = hash
  end

  def name
    item_hash[:name]
  end

  def id
    item_hash[:id]
  end

  def description
    item_hash[:description]
  end

  def unit_price
    item_hash[:unit_price]
  end

  def created_at
    item_hash[:created_at]
  end

  def updated_at
    item_hash[:updated_at]
  end

  def merchant_id
    item_hash[:merchant_id]
  end

  def unit_price_to_dollars
    unit_price.to_f / 100
  end
end
