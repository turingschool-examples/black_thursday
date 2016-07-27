require 'pry'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,
              :repo
  def initialize(hash, repo)
    @id = hash[:id]
    @name = hash[:name]
    @description = hash[:description]
    @unit_price = hash[:unit_price]
    @created_at = hash[:created_at]
    @updated_at = hash[:updated_at]
    @merchant_id = hash[:merchant_id]
    @repo = repo
  end

  def unit_price_to_dollars
    @unit_price.to_f
    # binding.pry
  end

end
