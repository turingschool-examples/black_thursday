require 'time'

class Item
  attr_reader   :id,
                :created_at,
                :merchant_id

  attr_accessor :name,
                :description,
                :unit_price,
                :updated_at

  def initialize(data)
    @id          = data[:id].to_i
    @name        = data[:name]
    @description = data[:description]
    @unit_price  = BigDecimal(data[:unit_price].to_f / 100, 4)
    @created_at  = set_time(data[:created_at].to_s)
    @updated_at  = set_time(data[:updated_at].to_s)
    @merchant_id = data[:merchant_id].to_i
  end

  def set_time(time)
    if time.nil?
      Time.now
    elsif time.empty?
      Time.now
    else
      Time.parse(time)
    end
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
