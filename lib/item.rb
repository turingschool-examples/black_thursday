class Item

  attr_reader :id,
              :merchant_id,
              :created_at

  attr_accessor :updated_at,
                :name,
                :description,
                :unit_price

  def initialize(item_hash, created_at=Time.now, updated_at=Time.now)
    @id = item_hash[:id]
    @name = item_hash[:name]
    @description = item_hash[:description]
    @unit_price = BigDecimal(item_hash[:unit_price]) / 100
    @created_at = Time.parse((item_hash[:created_at]).to_s)
    @updated_at = Time.parse((item_hash[:updated_at]).to_s)
    @merchant_id = item_hash[:merchant_id].to_i
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def create_id(new_id)
    @id = new_id.to_i
  end

  def price
    @unit_price.to_f
  end


end
