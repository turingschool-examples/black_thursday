require 'time'
require 'bigdecimal/util'
class Item

  attr_accessor :name,
                :description,
                :unit_price,
                :updated_at
  attr_reader :id,
              :merchant_id,
              :created_at


  def initialize (data, repository)
    @id          = data[:id]
    @name        = data[:name]
    @description = data[:description]
    @unit_price  = data[:unit_price].to_d
    @merchant_id = data[:merchant_id]
    @created_at  = Time.parse(data[:created_at].to_s)
    @updated_at  = Time.parse(data[:updated_at].to_s)
    @repository  = repository
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def update_attributes (new_attributes)
    @name = new_attributes[:name]
    @description = new_attributes[:description].downcase
    @unit_price = new_attributes[:unit_price]
    @updated_at = new_attributes[:updated_at] = Time.now
  end

end
