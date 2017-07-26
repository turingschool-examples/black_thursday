require 'time'
require 'bigdecimal'

class Item

  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id


  def initialize(hash, repo = nil)
    @id          = hash[:id].to_i
    @name        = hash[:name]
    @description = hash[:description]
    @unit_price  = BigDecimal.new(hash[:unit_price])
    @created_at  = Time.parse(hash[:created_at].to_s)
    @updated_at  = Time.parse(hash[:updated_at].to_s)
    @merchant_id = hash[:merchant_id].to_i
  end
end
