require 'time'

class Item
  attr_reader   :id,
                :name,
                :description,
                :unit_price,
                :created_at,
                :updated_at,
                :merchant_id

  def initialize(data)
    @id          = data[:id].to_i
    @name        = data[:name]
    @description = data[:description]
    @unit_price  = BigDecimal(data[:unit_price].to_f / 100, 4)
    @created_at  = update_time(data[:created_at].to_s)
    @updated_at  = update_time(data[:updated_at].to_s)
    @merchant_id = data[:merchant_id].to_i
  end

  def update_time(time)
    if time.nil?
      Time.now
    elsif time.empty?
      Time.now
    else
      Time.parse(time)
    end
  end

  def update(attributes)
    @name = attributes[:name] if !attributes[:name].nil?
    @description = attributes[:description] if !attributes[:description].nil?
    @unit_price  = BigDecimal(attributes[:unit_price]) if !attributes[:unit_price].nil?
    @updated_at  = update_time("")
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
