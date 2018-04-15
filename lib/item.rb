require 'bigdecimal'
require 'time'
class Item
  attr_reader :id,
              :created_at,
              :merchant_id,
              :item_repo,
              :name,
              :description,
              :unit_price,
              :updated_at

  def initialize(data, item_repo)
    @id = data[:id].to_i
    @name = data[:name]
    @description = data[:description]
    @unit_price = BigDecimal.new(data[:unit_price]) / 100.0
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @merchant_id = data[:merchant_id].to_i
    @item_repo = item_repo
  end

  def unit_price_to_dollars
    @unit_price.to_f
  end

  def merchant
    item_repo.sales_engine.merchants.find_by_id(merchant_id)
  end

  def update_updated_at
    @updated_at = Time.now
  end

  def update_name(name)
    @name = name
  end

  def update_description(description)
    @description = description
  end

  def update_unit_price(price)
    @unit_price = price
  end
end
