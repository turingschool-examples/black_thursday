require 'simplecov'
SimpleCov.start

class Item
  attr_reader :item_info,
              :id,
              :name,
              :description,
              :unit_price,
              :merchant_id,
              :created_at,
              :updated_at

  def initialize(item_info)
    @item_info         = item_info
    @id                = item_info[:id]
    @name              = item_info[:name]
    @description       = item_info[:description]
    @unit_price        = item_info[:unit_price]
    @merchant_id       = item_info[:merchant_id]
    @created_at        = item_info[:created_at]
    @updated_at        = item_info[:updated_at]
  end

  def unit_price_to_dollars
    ((@unit_price / 100).to_f).round(2)
  end

  def merchant
    se = SalesEngine.from_csv({
    :items     => "./data/items.csv",
    :merchants => "./data/merchants.csv",
    })
    se.merchants.find_by_id(merchant_id)
  end

end
