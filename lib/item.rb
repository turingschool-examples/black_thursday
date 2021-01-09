###Ask about created_at returns the Time the item was created and updated_at returns the Time the item was last updated!!#####

require 'bigdecimal'
require 'bigdecimal/util'
require 'time'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,
              :parent

  def initialize(args, parent)
    @args        = args
    @id          = args[:id].to_i
    @name        = args[:name].to_s
    @description = args[:description].to_s
    @unit_price  = (args[:unit_price].to_d) / 100
    @created_at  = Time.parse(args[:created_at].to_s)
    @updated_at  = Time.parse(args[:updated_at].to_s)
    @merchant_id = args[:merchant_id].to_s
    @parent = parent
  end

  def update(args)

    @unit_price  = (args[:unit_price].to_d) if !args[:unit_price].nil?
    @description = args[:description].to_s if !args[:description].nil?
    @name        = args[:name].to_s  if !args[:name].nil?
    @updated_at  = Time.now
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

end
