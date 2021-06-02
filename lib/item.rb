require 'CSV'
class Item

  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(item_data, repo)
    @id = item_data[:id]
    @name = item_data[:name]
    @description = item_data[:description]
    @unit_price = item_data[:unit_price]
    @merchant_id = item_data[:merchant_id]
    @created_at = item_data[:created_at]
    @updated_at = item_data[:updated_at]
    @repo = repo

  end

  def unit_price_to_dollars
    @unit_price.to_f
  end
end
