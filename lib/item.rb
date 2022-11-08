require 'bigdecimal'

class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(info, repo)
    @id = info[:id].to_i
    @name = info[:name]
    @description = info[:description]
    @unit_price = info[:unit_price].to_f
    @created_at = info[:created_at]
    @updated_at = info[:updated_at]
    @merchant_id = info[:merchant_id].to_i
    @repo = repo
  end

  def unit_price_to_dollars
    @unit_price.round(2).to_f
  end

  def update(attributes)
    @name = attributes[:name] if !attributes[:name].nil?
    @description = attributes[:description] if !attributes[:description].nil?
    @unit_price = attributes[:unit_price] if !attributes[:unit_price].nil?
    @updated_at = Time.now
  end

  # def merchant
  #   @repo.find_merchant_by_id(@merchant_id)
  # end

end