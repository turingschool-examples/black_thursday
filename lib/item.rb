require 'pry'

class Item
  attr_reader :id, 
              :created_at,
              :merchant_id

  attr_accessor :name,
                :description,
                :unit_price,
                :updated_at

  def initialize(hash)
    @id = hash[:id]
    @created_at = hash[:created_at]
    @merchant_id = hash[:merchant_id]
    
    @name = hash[:name]
    @description = hash[:description]
    @unit_price = hash[:unit_price]
    @updated_at = hash[:updated_at]
  end

end